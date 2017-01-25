//
//  Hubchat_PostsTests.swift
//  Hubchat PostsTests
//
//  Created by Jovito Royeca on 23/01/2017.
//  Copyright © 2017 Jovito Royeca. All rights reserved.
//

import XCTest
import Alamofire
import CoreData
import DATAStack
import Sync

@testable import Hubchat_Posts

class Hubchat_PostsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: Custom tests
    func testPostsAPI() {
        callAPI(PostsPath, completion: { (result: Any?, error: Error?) in
            if let error = error {
                print(error)
            } else {
                if let result = result {
                    print(result)
                }
            }
        })
    }

    func testForumAPI() {
        callAPI(ForumPath, completion: { (result: Any?, error: Error?) in
            if let error = error {
                print(error)
            } else {
                if let result = result {
                    print(result)
                }
            }
        })
    }
    
    func testSyncDB() {
        callAPI(PostsPath, completion: { (result: Any?, error: Error?) in
            if let error = error {
                print(error)
            } else {
                if let result = result as? [String: Any] {
                    let dataStack: DATAStack = DATAStack(modelName: "Hubchat")
                    let notifName = NSNotification.Name.NSManagedObjectContextObjectsDidChange
                    
                    dataStack.performInNewBackgroundContext { backgroundContext in
                        
                        NotificationCenter.default.addObserver(self, selector: #selector(Hubchat_PostsTests.changeNotification(_:)), name: notifName, object: backgroundContext)
                        
                        Sync.changes(result["posts"] as! Array,
                                     inEntityNamed: "Post",
                                     predicate: nil,
                                     parent: nil,
                                     parentRelationship: nil,
                                     inContext: backgroundContext,
                                     operations: .All,
                                     completion:  { error in
                                        
                                        NotificationCenter.default.removeObserver(self, name: notifName, object: nil)
                                        
                                        
                        })
                    }
                    
                }
            }
        })
    }
    
    
    // MARK: Utility methods
    func callAPI(_ path: String, completion: ((_ result: Any?, _ error: Error?) -> Void)?) {
        let ex = expectation(description: "Expecting a JSON data not nil")
        
        Alamofire.request(path).responseJSON { response in
            print("request = \(response.request!)")  // original URL request
            print("request = \(response.response!)") // HTTP URL response
            print("data = \(response.data!)")        // server data
            print("result = \(response.result)")     // result of response serialization
            
            XCTAssert(response.result.isSuccess == true)
            
            completion?(response.result.value, response.error)
            
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }

    func changeNotification(_ notification: NSNotification) {
        if let objects = notification.userInfo?[NSUpdatedObjectsKey] {
            print("updated: \((objects as AnyObject).count as UInt)")
        }
        
        if let objects = notification.userInfo?[NSDeletedObjectsKey] {
            print("deleted: \((objects as AnyObject).count as UInt)")
        }
        
        if let objects = notification.userInfo?[NSInsertedObjectsKey] {
            print("inserted: \((objects as AnyObject).count as UInt)")
        }
    }
}

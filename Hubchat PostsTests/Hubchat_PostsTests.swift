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
        callAPI(PostsPath)
    }

    func testForumAPI() {
        callAPI(ForumPath)
    }
    
    func testSyncDB() {
        let ex = expectation(description: "Expecting a JSON data not nil")
        
        Alamofire.request(PostsPath).responseJSON { response in
            XCTAssert(response.result.isSuccess == true)
            
            if let JSON = response.result.value as? [String: Any] {
                let dataStack: DATAStack = DATAStack(modelName: "Hubchat")
                let notifName = NSNotification.Name.NSManagedObjectContextObjectsDidChange
                
                dataStack.performInNewBackgroundContext { backgroundContext in
                    
                    NotificationCenter.default.addObserver(self, selector: #selector(Hubchat_PostsTests.changeNotification(_:)), name: notifName, object: backgroundContext)
                    
                    Sync.changes(JSON["posts"] as! Array,
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
            
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    
    // MARK: Utility methods
    func callAPI(_ path: String) {
        let ex = expectation(description: "Expecting a JSON data not nil")
        
        Alamofire.request(path).responseJSON { response in
            print("request = \(response.request!)")  // original URL request
            print("request = \(response.response!)") // HTTP URL response
            print("data = \(response.data!)")     // server data
            print("result = \(response.result)")   // result of response serialization
            
            XCTAssert(response.result.isSuccess == true)
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }

    func changeNotification(_ notification: NSNotification) {
        if let updatedObjects = notification.userInfo?[NSUpdatedObjectsKey] {
            print("updated: \(updatedObjects)")
        }
        
        if let deletedObjects = notification.userInfo?[NSDeletedObjectsKey] {
            print("deleted: \(deletedObjects)")
        }
        
        if let insertedObjects = notification.userInfo?[NSInsertedObjectsKey] {
            print("inserted: \(insertedObjects)")
        }
    }
}

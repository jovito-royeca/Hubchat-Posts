//
//  UtilityTests.swift
//  Hubchat Posts
//
//  Created by Jovito Royeca on 26/01/2017.
//  Copyright © 2017 Jovito Royeca. All rights reserved.
//

import XCTest

class UtilityTests: XCTestCase {
    
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
    
    func testFetchForum() {
        let ex = expectation(description: "Expecting a Forum not nil")
        
        let slug = "photography"
        Utility.sharedInstance.fetchForum(slug: slug, completion: { (forum: Forum?, error: Error?) in
            XCTAssertNotNil(forum)
            print("description: \(forum!.description_)")
            ex.fulfill()
        })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
}

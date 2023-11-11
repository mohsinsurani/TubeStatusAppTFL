//
//  TubeStatusAppUITests.swift
//  TubeStatusAppUITests
//
//  Created by Admin on 08/11/2023.
//

import XCTest

final class TubeStatusAppUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testData() throws {
        // Access the app
        let loadedListItem = app.staticTexts["Bakerloo"] // Replace with an actual line name
                
        // Wait for a reasonable amount of time for the data to load
        sleep(10)
                
        // Verify that a specific list item is present, indicating data is loaded
        XCTAssertTrue(loadedListItem.exists, "Data not loaded. Expected list item not found")
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
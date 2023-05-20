//
//  MizuameUITests.swift
//  MizuameUITests
//
//  Created by becomefoolish on 2023/05/07.
//

import XCTest

final class MizuameUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMizuame() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // FIX ME!!
        // UI test of statusbar don't work.
        // Is it impossible?
        
        //let mizuame = app.menuBarItems["Mizuame"]
        
        //Work
        //XCTAssertEqual(mizuame.isEnabled, true)
        
        //print("!!!!!!!!!:\(mizuame.isHittable)")
        //print("!!!!!!!!!:\(mizuame.title)")

        // Not work
        //mizuame.click()        
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

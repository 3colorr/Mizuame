//
//  MizuameTests.swift
//  MizuameTests
//
//  Created by becomefoolish on 2023/05/07.
//

import XCTest
@testable import Mizuame

final class MizuameTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    // Test DataIO class.
    //
    // JSON data for testing
    //   testContent1 = Content(markercolor = "ffffff", body = "test1")
    //   testContent2 = Content(markercolor = "000000", body = "test2")
    //   jsonData = StickyNote(tab = 1, contents = [testContent1, testContent2])
    //
    // test 1: write JSON data to JSON file(= stickyNote.json).
    // expected 1: writeStickyNote(of data: StickyNote) returns true.
    //
    // test 2: read JSON file(= stickyNote.json) to Data object, and then Data object convert to JSON data.
    // expected 2: writeStickyNote(of data: StickyNote) returns true.
    //
    func testDataIO() throws {
        let io = DataIO()

        // test 1
        let testContent1 = Content(markercolor: "ffffff", body: "test1")
        let testContent2 = Content(markercolor: "000000", body: "test2")
        let jsonData = StickyNote(tab: 1, contents: [testContent1, testContent2])
        XCTAssertTrue(io.writeStickyNote(of: jsonData))

        // test 2
        let data = io.readStickyNote()
        XCTAssertNotNil(data)
        XCTAssertEqual(data?.tab, 1)
        XCTAssertEqual(data?.contents[0].markercolor, "ffffff")
        XCTAssertEqual(data?.contents[0].body, "test1")
        XCTAssertEqual(data?.contents[1].markercolor, "000000")
        XCTAssertEqual(data?.contents[1].body, "test2")
    }
}

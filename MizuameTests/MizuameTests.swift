//
//  MizuameTests.swift
//  MizuameTests
//
//  Created by Nakamura Akira(3colorr) on 2023/05/07.
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
    
    // Test RedoUndo class.
    //
    // String data for testing
    //   testText = "abc"
    // Prepare
    //   RedoUndo instance is initialized with testText.
    //
    // test 1: Add "efg" to testText then store testText.
    // expected 1: snapshot(of note: String) returns true.
    //
    // test 2: Run "Undo".
    // expected 2: undo() returns "abc".
    //
    // test 3: Run "Redo".
    // expected 3: redo() returns "abcefg".
    //
    // test 4: Run "Redo" again.(A upper limit of redo history test)
    // expected 4: redo() returns "abcefg".
    //
    // test 5: Run "Undo" then store testText.
    // expected 5-1: undo() returns "abc".
    // expected 5-2: snapshot(of note: String) returns false.
    //               Because can not store same strings.
    //
    // test 6: Run "Undo" again.(A lower limit of undo history test)
    // expected 6: undo() returns "abc".
    //
    // test 7: Store testText while add "x(=1...30)" to one then Run "Undo" 30 times.
    //         (A upper limit of history test)
    // expected 7: 30th undo() returns "abc1".
    //
    func testRedoUndo() throws {
        var testText = "abc"
        let manager = RedoUndo(initialNote: testText)
        
        // test 1
        testText += "efg"
        XCTAssertTrue(manager.snapshot(of: testText))
        
        // test 2
        XCTAssertEqual(manager.undo(), "abc")
        
        // test 3
        XCTAssertEqual(manager.redo(), "abcefg")

        // test 4
        XCTAssertEqual(manager.redo(), "abcefg")

        // test 5
        testText = manager.undo()
        XCTAssertEqual(testText, "abc") //5-1
        XCTAssertFalse(manager.snapshot(of: testText)) //5-2
        
        // test 6
        testText = manager.undo()
        XCTAssertEqual(testText, "abc")

        // test 7
        for x in 1...30 {
            testText += String(x)
            _ = manager.snapshot(of: testText)
        }

        for _ in 1...30 {
            _ = manager.undo()
        }
        
        XCTAssertEqual(manager.undo(), "abc1")
    }
}

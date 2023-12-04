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

    // Test CalculateModel class.
    //
    // Prepare
    //   CalculateModel instance is initialized.
    //
    // test 1:
    //     Run result(formula: String) with "1+2+3+4+5".
    // expected 1:
    //     Returns 15.
    //
    // test 2:
    //     Run result(formula: String) with "(1+2)*3-9/(4.1+4.9)-8-0.1".
    // expected 2:
    //     Returns -0.1.
    //
    // test 3:
    //     3-1: Run result(formula: String) with "(1+2)*3-3^2".
    //     3-2: Run result(formula: String) with "1/3^3-3^-3".
    //     3-3: Run result(formula: String) with "1/3^3-3^(-3)".
    // expected 3:
    //     3-1: Returns 0.
    //     3-2: Returns 0.
    //     3-3: Returns 0.
    //
    // test 4:
    //     Run result(formula: String) with "-1+1-0.01^3*1000*1000".
    // expected 4:
    //     Returns -1.
    //
    // test 5:
    //     Run result(formula: String) with "0.01^(-3/2)".
    // expected 5:
    //     Returns 1000.
    //
    // test 6:
    //     Run result(formula: String) with "1+a+2".
    //     The formula contains a characters. Calculation fails.
    // expected 6:
    //     Returns nil.
    //
    // test 7:
    //     Run result(formula: String) with "1+2+3+".
    //     Wrong formula.  Calculation fails.
    // expected 7:
    //     Returns nil.
    //
    // test 8:
    //     Run result(formula: String) with "0.2*0.02^100".
    //     Underflow occurs.  Calculation fails.
    // expected 8:
    //     Returns nil.
    //
    func testCalculateModel() throws {
        let model = CalculateModel()

        // test 1
        XCTAssertEqual(model.result(formula: "1+2+3+4+5"), 15)

        // test 2
        XCTAssertEqual(model.result(formula: "(1+2)*3-9/(4.1+4.9)-8-0.1"), -0.1)

        // test 3
        // 3-1
        XCTAssertEqual(model.result(formula: "(1+2)*3-3^2"), 0)
        // 3-2
        XCTAssertEqual(model.result(formula: "1/3^3-3^-3"), 0)
        // 3-3
        XCTAssertEqual(model.result(formula: "1/3^3-3^(-3)"), 0)

        // test 4
        XCTAssertEqual(model.result(formula: "-1+1-0.01^3*1000*1000"), -1)

        // test 5
        XCTAssertNil(model.result(formula: "0.01^(3/2)"))
        
        // test 6
        XCTAssertNil(model.result(formula: "1+a+2"))

        // test 7
        XCTAssertNil(model.result(formula: "1+2+3+"))

        // test 8
        XCTAssertNil(model.result(formula: "0.2*0.02^100"))
    }
    
    // Test NoteParser class.
    //
    // Prepare
    //   NoteParser instance is initialized.
    //
    // test 1:
    //     Assign "abc(1+2+3=)" to 'testNote1'.
    //     Run parser(note: String) with 'testNote1' and receive the result in 'results1' array.
    // expected 1:
    //     The size of 'results1' array is 1.
    //     The range indicated by results1[0] in the 'testNote1' is "1+2+3".
    //
    // test 2:
    //     Assign "abc1+2+3=)(=)efg" to 'testNote2'.
    //     Run parser(note: String) with 'testNote2' and receive the result in 'results2' array.
    // expected 2:
    //     The size of 'results2' array is 1.
    //     The range indicated by results2[0] in the 'testNote2' is "".
    //
    // test 3:
    //     Assign "abc(1+2+3=(=)efg" to 'testNote3'.
    //     Run parser(note: String) with 'testNote3' and receive the result in 'results3' array.
    // expected 3:
    //     The size of 'results3' array is 1.
    //     The range indicated by results3[0] in the 'testNote3' is "".
    //
    // test 4:
    //     Assign "abc(1+2+3=" to 'testNote4'.
    //     Run parser(note: String) with 'testNote4' and receive the result in 'results4' array.
    // expected 4:
    //     The size of 'results4' array is 0.
    //
    // test 5:
    //     Assign "(1+2+3=)abc(4*a=)efg" to 'testNote5'.
    //     Run parser(note: String) with 'testNote5' and receive the result in 'results5' array.
    // expected 5:
    //     The size of 'results5' array is 2.
    //     The range indicated by results5[0] in the 'testNote5' is "1+2+3".
    //     The range indicated by results5[1] in the 'testNote5' is "4*a".
    //
    // test 6:
    //     Assign "(1+2+3= 5 )abc(4*a=)efg" to 'testNote6'.
    //     Run parser(note: String) with 'testNote6' and receive the result in 'results6' array.
    // expected 6:
    //     The size of 'results6' array is 1.
    //     The range indicated by results6[0] in the 'testNote6' is "4*a".
    //
    // test 7:
    //     Assign "(1+2+3 5 )(4*a=)" to 'testNote7'.
    //     Run parser(note: String) with 'testNote7' and receive the result in 'results7' array.
    // expected 7:
    //     The size of 'results7' array is 1.
    //     The range indicated by results7[0] in the 'testNote7' is "4*a".
    //
    // test 8:
    //     Assign "abc(" to 'testNote8'.
    //     Run parser(note: String) with 'testNote8' and receive the result in 'results8' array.
    // expected 8:
    //     The size of 'results8' array is 0.
    //
    func testNoteParser() throws {
        let parser = NoteParser()
        
        
        // test 1
        let testNote1 = "abc(1+2+3=)"
        let results1 = parser.parse(note: testNote1)
        XCTAssertEqual(results1.count, 1)
        XCTAssertEqual(testNote1[results1[0]], "1+2+3")
        
        // test 2
        let testNote2 = "abc1+2+3=)(=)efg"
        let results2 = parser.parse(note: testNote2)
        XCTAssertEqual(results2.count, 1)
        XCTAssertEqual(testNote2[results2[0]], "")

        // test 3
        let testNote3 = "abc(1+2+3=(=)efg"
        let results3 = parser.parse(note: testNote3)
        XCTAssertEqual(results3.count, 1)
        XCTAssertEqual(testNote3[results3[0]], "")

        // test 4
        let testNote4 = "abc(1+2+3="
        let results4 = parser.parse(note: testNote4)
        XCTAssertEqual(results4.count, 0)

        // test 5
        let testNote5 = "(1+2+3=)abc(4*a=)efg"
        let results5 = parser.parse(note: testNote5)
        XCTAssertEqual(results5.count, 2)
        XCTAssertEqual(testNote5[results5[0]], "1+2+3")
        XCTAssertEqual(testNote5[results5[1]], "4*a")

        // test 6
        let testNote6 = "(1+2+3= 5 )abc(4*a=)efg"
        let results6 = parser.parse(note: testNote6)
        XCTAssertEqual(results6.count, 1)
        XCTAssertEqual(testNote6[results6[0]], "4*a")

        // test 7
        let testNote7 = "(1+2+3 5 )(4*a=)"
        let results7 = parser.parse(note: testNote7)
        XCTAssertEqual(results7.count, 1)
        XCTAssertEqual(testNote7[results7[0]], "4*a")

        // test 8
        let testNote8 = "abc("
        let results8 = parser.parse(note: testNote8)
        XCTAssertEqual(results8.count, 0)
    }
}

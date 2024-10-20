//
//  MizuameTests.swift
//  MizuameTests
//
//  Created by Nakamura Akira(3colorr) on 2023/05/07.
//

import XCTest
import SwiftUI
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
    // test 9:
    //     Rounding test.
    //     9-1: Run result(formula: String) with "1/3" and rounds to 4 decimal placed.
    //     9-2: Run result(formula: String) with "1/3" and rounds to 2 decimal placed.
    //     9-3: Run result(formula: String) with "1/3" and rounds to 1 decimal placed.
    //     9-4: Run result(formula: String) with "0.1234567+0.1" and no rounds.
    // expected 9:
    //     9-1: Returns 0.333.
    //     9-2: Returns 0.3.
    //     9-3: Returns 0.
    //     9-4: Returns 0.2234567.
    //
    func testCalculateModel() throws {
        let model = CalculateModel(digitAfterDecimalPoint: 3)

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

        // test 9
        // 9-1
        let model9_1 = CalculateModel(digitAfterDecimalPoint: 3)
        XCTAssertEqual(model9_1.result(formula: "1/3"), 0.333)
        
        // 9-2
        let model9_2 = CalculateModel(digitAfterDecimalPoint: 1)
        XCTAssertEqual(model9_2.result(formula: "1/3"), 0.3)

        // 9-3
        let model9_3 = CalculateModel(digitAfterDecimalPoint: 0)
        XCTAssertEqual(model9_3.result(formula: "1/3"), 0)

        // 9-4
        let model9_4 = CalculateModel(digitAfterDecimalPoint: -1)
        XCTAssertEqual(model9_4.result(formula: "0.1234567+0.1"), 0.2234567)
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
    // test 9:
    //     Assign "abc((2+2)^3=)" to 'testNote9'.
    //     Run parser(note: String) with 'testNote9' and receive the result in 'results9' array.
    // expected 9:
    //     The size of 'results9' array is 1.
    //     The range indicated by results9[0] in the 'testNote9' is "64".
    //
    func testNoteParser_getFormulas() throws {
        
        // test 1
        let testNote1 = "abc(1+2+3=)"
        let results1 = testNote1.getFormulas()//parser.parseFormulasIn(note: testNote1)
        XCTAssertEqual(results1.count, 1)
        XCTAssertEqual(testNote1[results1[0]], "1+2+3")
        
        // test 2
        let testNote2 = "abc1+2+3=)(=)efg"
        let results2 = testNote2.getFormulas()//parser.parseFormulasIn(note: testNote2)
        XCTAssertEqual(results2.count, 0)
        //XCTAssertEqual(testNote2[results2[0]], "")

        // test 3
        let testNote3 = "abc(1+2+3=(=)efg"
        let results3 = testNote3.getFormulas()//parser.parseFormulasIn(note: testNote3)
        XCTAssertEqual(results3.count, 0)
        //XCTAssertEqual(testNote3[results3[0]], "")

        // test 4
        let testNote4 = "abc(1+2+3="
        let results4 = testNote4.getFormulas()//parser.parseFormulasIn(note: testNote4)
        XCTAssertEqual(results4.count, 0)

        // test 5
        let testNote5 = "(1+2+3=)abc(4*a=)efg"
        let results5 = testNote5.getFormulas()//parser.parseFormulasIn(note: testNote5)
        XCTAssertEqual(results5.count, 2)
        XCTAssertEqual(testNote5[results5[0]], "1+2+3")
        XCTAssertEqual(testNote5[results5[1]], "4*a")

        // test 6
        let testNote6 = "(1+2+3= 5 )abc(4*a=)efg"
        let results6 = testNote6.getFormulas()//parser.parseFormulasIn(note: testNote6)
        XCTAssertEqual(results6.count, 1)
        XCTAssertEqual(testNote6[results6[0]], "4*a")

        // test 7
        let testNote7 = "(1+2+3 5 )(4*a=)"
        let results7 = testNote7.getFormulas()//parser.parseFormulasIn(note: testNote7)
        XCTAssertEqual(results7.count, 1)
        XCTAssertEqual(testNote7[results7[0]], "4*a")

        // test 8
        let testNote8 = "abc("
        let results8 = testNote8.getFormulas()//parser.parseFormulasIn(note: testNote8)
        XCTAssertEqual(results8.count, 0)

        // test 9
        let testNote9 = "abc((2+2)^3=)"
        let results9 = testNote9.getFormulas()//parser.parseFormulasIn(note: testNote9)
        XCTAssertEqual(results9.count, 1)
        XCTAssertEqual(testNote9[results9[0]], "(2+2)^3")
    }

    func testNoteParser_toMarkdown() throws {

        let testNote = """
abc
# header 1
## header 2
### header 3
#### header 4
##### header 5
###### header 6\n
efg
- list 1
  - list 2
    - list 3
      - list 4
hij
k `code block` L (1+2= 3 )
"""

        let markdownModels: [MarkdownModel] = testNote.toMarkdown(size: 12)

        XCTAssertEqual(markdownModels.count, 14)

        XCTAssertEqual(markdownModels[0].markdownTextViews.count, 1)
        XCTAssertEqual(markdownModels[0].markdownTextViews[0].text, "abc")
        XCTAssertEqual(markdownModels[0].markdownTextViews[0].viewType, MarkdownTextViewType.plain)

        XCTAssertEqual(markdownModels[1].markdownTextViews.count, 1)
        XCTAssertEqual(markdownModels[1].markdownTextViews[0].text, "header 1")
        XCTAssertEqual(markdownModels[1].markdownTextViews[0].viewType, MarkdownTextViewType.header1)

        XCTAssertEqual(markdownModels[2].markdownTextViews.count, 1)
        XCTAssertEqual(markdownModels[2].markdownTextViews[0].text, "header 2")
        XCTAssertEqual(markdownModels[2].markdownTextViews[0].viewType, MarkdownTextViewType.header2)

        XCTAssertEqual(markdownModels[3].markdownTextViews.count, 1)
        XCTAssertEqual(markdownModels[3].markdownTextViews[0].text, "header 3")
        XCTAssertEqual(markdownModels[3].markdownTextViews[0].viewType, MarkdownTextViewType.header3)

        XCTAssertEqual(markdownModels[4].markdownTextViews.count, 1)
        XCTAssertEqual(markdownModels[4].markdownTextViews[0].text, "header 4")
        XCTAssertEqual(markdownModels[4].markdownTextViews[0].viewType, MarkdownTextViewType.header4)

        XCTAssertEqual(markdownModels[5].markdownTextViews.count, 1)
        XCTAssertEqual(markdownModels[5].markdownTextViews[0].text, "header 5")
        XCTAssertEqual(markdownModels[5].markdownTextViews[0].viewType, MarkdownTextViewType.header5)

        XCTAssertEqual(markdownModels[6].markdownTextViews.count, 1)
        XCTAssertEqual(markdownModels[6].markdownTextViews[0].text, "header 6")
        XCTAssertEqual(markdownModels[6].markdownTextViews[0].viewType, MarkdownTextViewType.header6)

        XCTAssertEqual(markdownModels[7].markdownTextViews.count, 1)
        XCTAssertEqual(markdownModels[7].markdownTextViews[0].text, "efg")
        XCTAssertEqual(markdownModels[7].markdownTextViews[0].viewType, .plain)

        XCTAssertEqual(markdownModels[8].markdownTextViews.count, 1)
        XCTAssertEqual(markdownModels[8].markdownTextViews[0].text, "list 1")
        XCTAssertEqual(markdownModels[8].markdownTextViews[0].viewType, MarkdownTextViewType.list1)

        XCTAssertEqual(markdownModels[9].markdownTextViews.count, 1)
        XCTAssertEqual(markdownModels[9].markdownTextViews[0].text, "list 2")
        XCTAssertEqual(markdownModels[9].markdownTextViews[0].viewType, MarkdownTextViewType.list2)

        XCTAssertEqual(markdownModels[10].markdownTextViews.count, 1)
        XCTAssertEqual(markdownModels[10].markdownTextViews[0].text, "list 3")
        XCTAssertEqual(markdownModels[10].markdownTextViews[0].viewType, MarkdownTextViewType.list3)

        XCTAssertEqual(markdownModels[10].markdownTextViews.count, 1)
        XCTAssertEqual(markdownModels[10].markdownTextViews[0].text, "list 3")
        XCTAssertEqual(markdownModels[10].markdownTextViews[0].viewType, MarkdownTextViewType.list3)

        XCTAssertEqual(markdownModels[11].markdownTextViews.count, 1)
        XCTAssertEqual(markdownModels[11].markdownTextViews[0].text, "list 4")
        XCTAssertEqual(markdownModels[11].markdownTextViews[0].viewType, MarkdownTextViewType.list4)

        XCTAssertEqual(markdownModels[12].markdownTextViews.count, 1)
        XCTAssertEqual(markdownModels[12].markdownTextViews[0].text, "hij")

        XCTAssertEqual(markdownModels[13].markdownTextViews.count, 4)
        XCTAssertEqual(markdownModels[13].markdownTextViews[0].text, "k ")
        XCTAssertEqual(markdownModels[13].markdownTextViews[0].viewType, MarkdownTextViewType.plain)
        XCTAssertEqual(markdownModels[13].markdownTextViews[1].text, "code block")
        XCTAssertEqual(markdownModels[13].markdownTextViews[1].viewType, MarkdownTextViewType.codeblock)
        XCTAssertEqual(markdownModels[13].markdownTextViews[2].text, " L ")
        XCTAssertEqual(markdownModels[13].markdownTextViews[2].viewType, MarkdownTextViewType.plain)
        XCTAssertEqual(markdownModels[13].markdownTextViews[3].text, "1+2= 3 ")
        XCTAssertEqual(markdownModels[13].markdownTextViews[3].viewType, MarkdownTextViewType.formula)
    }

    func testNoteParser_findRangeOfCode() throws {

        let test1 = "abc`efg`hij"
        let testRange1 = test1.findRangeOfCode()
        XCTAssertEqual(testRange1.count, 1)
        XCTAssertEqual(test1[testRange1[0]], "efg")

        let test2 = "abc`efg`hij`klm`nop"
        let testRange2 = test2.findRangeOfCode()
        XCTAssertEqual(testRange2.count, 2)
        XCTAssertEqual(test2[testRange2[0]], "efg")
        XCTAssertEqual(test2[testRange2[1]], "klm")

        let test3 = "abc`efg``hij`klm"
        let testRange3 = test3.findRangeOfCode()
        XCTAssertEqual(testRange3.count, 2)
        XCTAssertEqual(test3[testRange3[0]], "efg")
        XCTAssertEqual(test3[testRange3[1]], "hij")

        let test4 = "`abc``efg`"
        let testRange4 = test4.findRangeOfCode()
        XCTAssertEqual(testRange4.count, 2)
        XCTAssertEqual(test4[testRange4[0]], "abc")
        XCTAssertEqual(test4[testRange4[1]], "efg")

        let test5 = "`abc`efg`"
        let testRange5 = test5.findRangeOfCode()
        XCTAssertEqual(testRange5.count, 1)
        XCTAssertEqual(test5[testRange5[0]], "abc")

        let test6 = "abc"
        let testRange6 = test6.findRangeOfCode()
        XCTAssertEqual(testRange6.count, 0)

        let test7 = "abc`"
        let testRange7 = test7.findRangeOfCode()
        XCTAssertEqual(testRange7.count, 0)

        let test8 = "`abc"
        let testRange8 = test8.findRangeOfCode()
        XCTAssertEqual(testRange8.count, 0)
    }

    func testNoteParser_findRangeOfFormula() throws {

        let test1 = "abc(1+2= 3 )efg"
        let testRange1 = test1.findRangeOfFormula()
        XCTAssertEqual(testRange1.count, 1)
        XCTAssertEqual(test1[testRange1[0].formula], "1+2=")
        XCTAssertEqual(test1[testRange1[0].calculateResult], " 3 ")

        let test2 = "abc((1+2)*2= 6 )efg"
        let testRange2 = test2.findRangeOfFormula()
        XCTAssertEqual(testRange2.count, 1)
        XCTAssertEqual(test2[testRange2[0].formula], "(1+2)*2=")
        XCTAssertEqual(test2[testRange2[0].calculateResult], " 6 ")

        let test3 = "(1+2= 3 )abc(3*(1+2)= 9 )"
        let testRange3 = test3.findRangeOfFormula()
        XCTAssertEqual(testRange3.count, 2)
        XCTAssertEqual(test3[testRange3[0].formula], "1+2=")
        XCTAssertEqual(test3[testRange3[0].calculateResult], " 3 ")
        XCTAssertEqual(test3[testRange3[1].formula], "3*(1+2)=")
        XCTAssertEqual(test3[testRange3[1].calculateResult], " 9 ")

        let test4 = "(1+2)abc(1/2= 0.5 )"
        let testRange4 = test4.findRangeOfFormula()
        XCTAssertEqual(testRange4.count, 1)
        XCTAssertEqual(test4[testRange4[0].formula], "1/2=")
        XCTAssertEqual(test4[testRange4[0].calculateResult], " 0.5 ")

        // The Test5 is fail because the Mizuame cannot calculate "test5"
        // https://github.com/3colorr/Mizuame/issues/143
        /*
        let test5 = "(1+2= 3 )abc(3*(1+2= 9 )(5/(5)= 1)(1/2= 0.5 )"
        let testRange5 = test5.findRangeOfFormula()
        XCTAssertEqual(testRange5.count, 3)
        XCTAssertEqual(test5[testRange5[0].formula], "1+2=")
        XCTAssertEqual(test5[testRange5[0].calculateResult], " 3 ")
        XCTAssertEqual(test5[testRange5[1].formula], "5/(5)=")
        XCTAssertEqual(test5[testRange5[1].calculateResult], " 1 ")
        XCTAssertEqual(test5[testRange5[2].formula], "1/2=")
        XCTAssertEqual(test5[testRange5[2].calculateResult], " 0.5 ")
        */

        let test6 = "abc"
        let testRange6 = test6.findRangeOfFormula()
        XCTAssertEqual(testRange6.count, 0)

        let test7 = "abc("
        let testRange7 = test7.findRangeOfFormula()
        XCTAssertEqual(testRange7.count, 0)

        let test8 = "abc(1+2= 3 "
        let testRange8 = test8.findRangeOfFormula()
        XCTAssertEqual(testRange8.count, 0)
    }
}

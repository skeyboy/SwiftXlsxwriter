import XCTest

@testable import SwiftXlsxwriter

final class SwiftXlsxwriterTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
    func testSXWorkbook() {
        let fileName = "test"
        let workbook = SXWorkbook(fileName)
        assert(workbook.isOpened, "file is auto closed")
        assert(workbook.fileName == "test.xlsx", "filename need test.xlsx")
        assert(workbook.close(), "close error")
        assert(workbook.isOpened == false, "the file has not closed")
    }

    func testSXWorksheet() {
        let fileName = "./test_worksheet"
        let workbook = SXWorkbook(fileName)
        let sheetA = try? workbook.add(worksheet: "A")
        assert(sheetA != nil, "add sheet failed")
        assert(
            sheetA?.write(vale: "Hello world", row: 0, col: 0),
            "write string value failed"
        )
    }
}

func assert(
    _ condition: @autoclosure () -> SXError?, _ message: @autoclosure () -> String = String(),
    file: StaticString = #file, line: UInt = #line
) {
    assert(condition()?.isSuccess ?? false, message(), file: file, line: line)
}

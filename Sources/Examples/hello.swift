/*
 lxw_workbook  *workbook  = workbook_new("hello_world.xlsx");
    lxw_worksheet *worksheet = workbook_add_worksheet(workbook, NULL);

    worksheet_write_string(worksheet, 0, 0, "Hello", NULL);
    worksheet_write_number(worksheet, 1, 0, 123, NULL);

    workbook_close(workbook);
    */

import Foundation
import SwiftXlsxwriter

@main
struct Hello {
    static func main() {
        print("Hello", #file, #line)
        let workbook = SXWorkbook("hello_world")
        let worksheet = try? workbook.add(worksheet: "A")
        worksheet?.write(vale: "Hello world", row: 0, col: 0)
        workbook.close()
    }
}

import libxlsxwriter

public class SXWorkbook {
    public private(set) var fileName: String
    public private(set) var isOpened = true
    public private(set) lazy var workbook: UnsafeMutablePointer<lxw_workbook> = workbook_new(
        fileName
    )
    {
        didSet {
            isOpened = true
        }
    }
    public init(_ fileName: String, extension fileExtension: String = "xlsx") {
        if !fileName.hasSuffix("xlsx") {
            self.fileName = fileName + "." + fileExtension
        } else {
            self.fileName = fileName
        }
        _ = workbook
    }

    public func add(worksheet name: String = "Sheet A") throws
        -> SXWorksheet?
    {

        let pWorksheet = workbook_add_worksheet(workbook, name)
        return try SXWorksheet(pWorksheet)
    }

    deinit {
        if isOpened {
            close()
        }
        print("SXWorkbook deinit", "file ", #file, " line ", #line)
    }

    @discardableResult
    public func close() -> SXError {
        isOpened = false
        return workbook_close(workbook).error
    }
}

import libxlsxwriter

public class SXWorkbook : SXBase<lxw_workbook> {
    public private(set) var fileName: String
    public private(set) var isOpened = true
    public internal(set) var workbook: UnsafeMutablePointer<lxw_workbook> {
        didSet {
            isOpened = true
        }
    }
    
    public init(_ fileName: String, extension fileExtension: String = "xlsx") {
        var tempFileName = fileName
        if !fileName.hasSuffix("xlsx") {
            tempFileName = fileName + "." + fileExtension
        } else {
            tempFileName = fileName
        }
        self.fileName = tempFileName
        let workbook = workbook_new(tempFileName)
        self.workbook = workbook!
        super.init(workbook!.pointee)
    }

    public func add(worksheet name: String = "Sheet A") throws
        -> SXWorksheet?
    {
        return try SXWorksheet(self, sheetName: name)
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
        return workbook_close(&baseSXValue).error
    }
}

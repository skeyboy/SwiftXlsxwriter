import libxlsxwriter

public class SXBase<T> {
    
    public var onError: ((SXError)-> Void)? = nil
    
    public internal(set) var baseSXValue: T {
        didSet {
            onSXValue(baseSXValue)
        }
    }

    func onError(fun: String = #function, line: Int = #line, error: ()->SXError?) -> Self {
        if let error = error() {
            onError?(error)
        }
        return self
    }
    
    func onSXValue(_ value: T) {
        
    }
    
    public init(_ value: T) {
        self.baseSXValue = value
    }
}

public class SXWorksheet : SXBase<lxw_worksheet> {
    public internal(set) weak var workbook: SXWorkbook? = nil
    public init?(_ worksheet: UnsafeMutablePointer<lxw_worksheet>?) throws {
        guard let worksheet = worksheet else {
            Swift.fatalError("SXWorksheet init with worksheet error")
        }
        super.init(worksheet.pointee)
    }

    public convenience init?(_ workbook: SXWorkbook, sheetName name: String = "Sheet A") throws {
        let pWorksheet = workbook_add_worksheet(workbook.workbook, name)
        try? self.init(pWorksheet)
    }

    @discardableResult
    public func write(
        vale string: String, row: UInt32, col: UInt16, format: SXFormat = .init()
    ) -> Self {
        onError {
            worksheet_write_string(
                &baseSXValue, row, col, string,
                &format.format
            ).error
        }
    }

    @discardableResult
    public func write(
        value number: Double, row: UInt32, col: UInt16, format: SXFormat = .init()
    ) -> Self {
        onError {
            worksheet_write_number(&baseSXValue, row, col, number, &format.format).error
        }
    }

    @discardableResult
    public func setColum(
        first fCol: UInt16, last lCol: UInt16, width: Double, format: SXFormat = .init()
    ) -> Self {
        onError {
            worksheet_set_column(&baseSXValue, fCol, lCol, width, &format.format).error
        }
    }
}

import libxlsxwriter

public class SXFormat: SXBase<lxw_format> {
    public internal(set) var format: lxw_format
    weak var workbook: SXWorkbook?
    
    public init(_ workbook: SXWorkbook? = nil) {
        self.workbook = workbook
        self.format = workbook == nil ? lxw_format() : workbook_add_format(workbook?.workbook).pointee
        super.init(format)
    }

    @discardableResult
    public func blod() -> Self {
        format_set_bold(&format)
        isBold = true
        return self
    }
    public private(set) var isBold: Bool = false
}

extension SXWorkbook {
    public var newFormat: SXFormat {
        SXFormat(self)
    }
}

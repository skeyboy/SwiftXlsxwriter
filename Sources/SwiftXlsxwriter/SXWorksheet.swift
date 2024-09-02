import libxlsxwriter

public class SXWorksheet {
    public private(set) var worksheet: lxw_worksheet
    public init?(_ worksheet: UnsafeMutablePointer<lxw_worksheet>?) throws {
        guard let worksheet = worksheet else {
            Swift.fatalError("SXWorksheet init with worksheet error")
        }
        self.worksheet = worksheet.pointee
    }

    @discardableResult
    public func write(
        vale string: String, row: UInt32, col: UInt16, format: SXFormat = .init()
    ) -> SXError {
        worksheet_write_string(
            &worksheet, row, col, string,
            &format.format
        ).error
    }

    public func write(
        value number: Double, row: UInt32, col: UInt16, format: SXFormat = .init()
    ) -> SXError {
        worksheet_write_number(&worksheet, row, col, number, &format.format).error
    }
}

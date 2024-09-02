import libxlsxwriter

extension lxw_error {
    public var error: SXError {
        return .init(rawValue: self.rawValue) ?? .noError
    }
}

public enum SXError: UInt32, Equatable, RawRepresentable {

    public typealias RawValue = UInt32

    public init?(rawValue: lxw_error) {
        self = SXError(rawValue: rawValue.rawValue) ?? SXError.noError
    }

    public init?(_ value: UInt32) {
        self.init(rawValue: lxw_error(value))
    }

    /** No error. */
    case noError

    /** Memory error, failed to malloc() required memory. */
    case memoryMallocFailed

    /** Error creating output xlsx file. Usually a permissions error. */
    case creatingXlsFile

    /** Error encountered when creating a tmpfile during file assembly. */
    case creatingTmpFile

    /** Error reading a tmpfile. */
    case readingTmpFile

    /** Zip generic error ZIP_ERRNO while creating the xlsx file. */
    case zipFIleOperation

    /** Zip error ZIP_PARAMERROR while creating the xlsx file. */
    case zipParameter

    /** Zip error ZIP_BADZIPFILE (use_zip64 option may be required). */
    case zipBadZipFile

    /** Zip error ZIP_INTERNALERROR while creating the xlsx file. */
    case zipInternal

    /** File error or unknown zip error when adding sub file to xlsx file. */
    case zipFileAdd

    /** Unknown zip error when closing xlsx file. */
    case zipClose

    /** Feature is not currently supported in this configuration. */
    case featureNotSuppoeted

    /** NULL function parameter ignored. */
    case nullParameterIgnored

    /** Function parameter validation error. */
    case parameterValidation

    /** Worksheet name exceeds Excel's limit of 31 characters. */
    case sheetNameLenghtExceeded

    /** Worksheet name cannot contain invalid characters: '[ ] : * ? / \\' */
    case invalidSheetnameCharacter

    /** Worksheet name cannot start or end with an apostrophe. */
    case sheetnameStartEndApostrophe

    /** Worksheet name is already in use. */
    case sheetNameAlreadyUsed

    /** Parameter exceeds Excel's limit of 32 characters. */
    case stringLengthExceededOf32

    /** Parameter exceeds Excel's limit of 128 characters. */
    case stringLengthExceededOf128

    /** Parameter exceeds Excel's limit of 255 characters. */
    case stringLengthExceededOf255

    /** String exceeds Excel's limit of 32,767 characters. */
    case maxStringLengthExceeded

    /** Error finding internal string index. */
    case LXW_ERROR_SHARED_STRING_INDEX_NOT_FOUND

    /** Worksheet row or column index out of range. */
    case worksheetIndexOutOfRange

    /** Maximum hyperlink length (2079) exceeded. */
    case worksheetMaxUrlLengthExceeded

    /** Maximum number of worksheet URLs (65530) exceeded. */
    case worksheetMaxNumberUrlsExceeded

    /** Couldn't read image dimensions or DPI. */
    case imageDimensions
    case maxErrno
}

extension SXError {
    var isSuccess: Bool {
        self == .noError
    }
    var isFailure: Bool {
        !isSuccess
    }
}

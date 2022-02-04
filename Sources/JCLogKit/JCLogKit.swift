import os.log

public struct JCLogKit {

    public init() {}
    
    /// Logs to console to support on-device debugging in release mode,
    /// otherwise prints to console during dev to reduce timestamp clutter.
    public static func add(_ info: String, type: OSLogType, category: LogCategory) {
        #if DEBUG
        var emoji = ""
        switch type {
        case .info: emoji = "ℹ️"
        case .error: emoji = "‼️"
        default: emoji = "ℹ️"
        }
        let message = "[Jerrycan][\(emoji)] " + info
        print(message)
        return
        #else
        let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: category.rawValue)
        let message = "[Jerrycan] " + info
        os_log("%{public}@", log: log, type: type, message)
        #endif
    }
}

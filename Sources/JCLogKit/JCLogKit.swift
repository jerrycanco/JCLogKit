import os.log
import Foundation

public struct JCLogKit {

    public init() {}
    
    /// Logs to console to support on-device debugging in release mode,
    /// otherwise prints to console during dev to reduce timestamp clutter.
    public static func add(_ info: String, type: OSLogType, category: LogCategory) {
        #if DEBUG
        var emoji = ""
        switch type {
        case .info: emoji = category == .urlRequest ? "🌎" : "ℹ️"
        case .error: emoji = "‼️"
        default: emoji = "ℹ️"
        }

        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let nanoSeconds = calendar.component(.nanosecond, from: date)
        let trimmedNanoSeconds = "\(nanoSeconds)".prefix(3)
        let timestamp = "\(hour):\(minutes):\(seconds):\(trimmedNanoSeconds)"
        let message = "[Jerrycan][\(emoji)][\(timestamp)] " + info
        print(message)
        return
        #else
        let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: category.rawValue)
        let message = "[Jerrycan] " + info
        os_log("%{public}@", log: log, type: type, message)
        #endif
    }
}

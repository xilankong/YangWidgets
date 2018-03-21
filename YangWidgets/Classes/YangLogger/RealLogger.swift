//
//  RealLogger.swift
//  iReal
//
//  Created by lbencs on 24/01/2018.
//  Copyright © 2018 lbencs. All rights reserved.
//

import Foundation
import CocoaLumberjack

public enum RealLogLevel {
    case all
    case verbose
    case debug
    case info
    case warning
    case error
}
public enum RealLogFlag {
    case verbose
    case debug
    case info
    case warning
    case error
}

/// Debug or Release
///
/// - debug: 1. 日志以同步的方式输出
/// - release: 1. 日志以异步的方式输出
public enum RealLogPattern {
    case debug
    case release
}

final public class RealLogger {
    
    public static let share = RealLogger()
    
    public static var debugLogLevel: RealLogLevel = .debug
    public static var releaseLogLevel: RealLogLevel = .info
    
    /// 模式： RealLogPattern
    public var pattern: RealLogPattern = .debug
    
    private init() {
        
        if let ddoslogger = DDOSLogger.sharedInstance {
            ddoslogger.logFormatter = RealLogFormatter()
            DDLog.add(ddoslogger, with: pattern.level.toLumberjack)
        }
       
        let fileManager = DDLogFileManagerDefault()
        if let fileLogger = DDFileLogger(logFileManager: fileManager) {
            fileLogger.logFormatter = RealLogFormatter()
            DDLog.add(fileLogger, with: pattern.level.toLumberjack)
        }
        
        DDLog.remove(DDTTYLogger.sharedInstance)
    }

    func log(flag: RealLogFlag, message: @autoclosure () -> Any?, file: StaticString, function: StaticString?, line: UInt) {
        let message = DDLogMessage(
            message: "\(message() ?? "")",
            level: pattern.level.toLumberjack,
            flag: flag.toLumberjack,
            context: 0,
            file: "\(file)",
            function: "\(function ?? ""))",
            line: line,
            tag: nil,
            options: [.copyFile, .copyFunction],
            timestamp: nil)
        DDLog.log(asynchronous: pattern.isAsync, message: message)
    }
}

extension RealLogPattern {
    var isAsync: Bool {
        return self == .release
    }
    public var level: RealLogLevel {
        switch self {
        case .debug:
            return RealLogger.debugLogLevel
        case .release:
            return RealLogger.debugLogLevel
        }
    }
}

extension DDLogFlag {
    var description: String {
        switch self {
        case .verbose:
            return "🍄【Verbose】"
        case .debug:
            return "🎲【Debug】"
        case .info:
            return "🐳【Info】"
        case .warning:
            return "💀【Warning】"
        case .error:
            return "❌【Error】"
        default:
            return ""
        }
    }
}

extension RealLogFlag {
    var toLumberjack: DDLogFlag {
        switch self {
        case .verbose:
            return DDLogFlag.verbose
        case .debug:
            return DDLogFlag.debug
        case .info:
            return DDLogFlag.info
        case .warning:
            return DDLogFlag.warning
        case .error:
            return DDLogFlag.error
        }
    }
}

extension RealLogLevel {
    var toLumberjack: DDLogLevel {
        switch self {
        case .all:
            return DDLogLevel.all
        case .verbose:
            return DDLogLevel.verbose
        case .debug:
            return DDLogLevel.debug
        case .info:
            return DDLogLevel.info
        case .warning:
            return DDLogLevel.warning
        case .error:
            return DDLogLevel.error
        }
    }
}

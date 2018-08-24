//
//  Logger.swift
//  i
//
//  Created by lbencs on 24/01/2018.
//  Copyright © 2018 lbencs. All rights reserved.
//

import Foundation
import CocoaLumberjack


/// 日志等级
///
/// - all: 全部
/// - verbose: 描述信息
/// - debug: Debug信息
/// - info: 普通信息
/// - warning: 警告
/// - error: 错误
public enum LogLevel {
    case all
    case verbose
    case debug
    case info
    case warning
    case error
}

public enum LogFlag {
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
public enum LogPattern {
    case debug
    case release
}

final public class Logger {
    
    public static let share = Logger()
    
    public static var debugLogLevel: LogLevel = .debug
    public static var releaseLogLevel: LogLevel = .info
    
    /// 模式： LogPattern
    public var pattern: LogPattern = .debug
    
    private init() {
        
        if let ddoslogger = DDOSLogger.sharedInstance {
            ddoslogger.logFormatter = LogFormatter()
            DDLog.add(ddoslogger, with: pattern.level.toLumberjack)
        }
       
        let fileManager = DDLogFileManagerDefault()
        if let fileLogger = DDFileLogger(logFileManager: fileManager) {
            fileLogger.logFormatter = LogFormatter()
            DDLog.add(fileLogger, with: pattern.level.toLumberjack)
        }
        
        DDLog.remove(DDTTYLogger.sharedInstance)
    }

    func log(flag: LogFlag, message: @autoclosure () -> Any?, file: StaticString, function: StaticString?, line: UInt) {
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

extension LogPattern {
    var isAsync: Bool {
        return self == .release
    }
    public var level: LogLevel {
        switch self {
        case .debug:
            return Logger.debugLogLevel
        case .release:
            return Logger.debugLogLevel
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

extension LogFlag {
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

extension LogLevel {
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

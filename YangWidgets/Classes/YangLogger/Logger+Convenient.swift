//
//  Logger+Convenient.swift
//  Alamofire
//
//  Created by lbencs on 30/01/2018.
//

import Foundation
import CocoaLumberjack

public func LogDebug(_ message: @autoclosure () -> Any?, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    Logger.share.log(flag: .debug, message: message, file: file, function: function, line: line)
}
public func LogInfo(_ message: @autoclosure () -> Any?, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    Logger.share.log(flag: .info, message: message, file: file, function: function, line: line)
}
public func LogWarn(_ message: @autoclosure () -> Any?, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    Logger.share.log(flag: .warning, message: message, file: file, function: function, line: line)
}
public func LogVerbose(_ message: @autoclosure () -> Any?, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    Logger.share.log(flag: .verbose, message: message, file: file, function: function, line: line)
}
public func LogError(_ message: @autoclosure () -> Any?, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    Logger.share.log(flag: .error, message: message, file: file, function: function, line: line)
}

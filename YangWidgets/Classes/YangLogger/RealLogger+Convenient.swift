//
//  RealLogger+Convenient.swift
//  Alamofire
//
//  Created by lbencs on 30/01/2018.
//

import Foundation
import CocoaLumberjack

public func RealLogDebug(_ message: @autoclosure () -> Any?, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    RealLogger.share.log(flag: .debug, message: message, file: file, function: function, line: line)
}
public func RealLogInfo(_ message: @autoclosure () -> Any?, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    RealLogger.share.log(flag: .info, message: message, file: file, function: function, line: line)
}
public func RealLogWarn(_ message: @autoclosure () -> Any?, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    RealLogger.share.log(flag: .warning, message: message, file: file, function: function, line: line)
}
public func RealLogVerbose(_ message: @autoclosure () -> Any?, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    RealLogger.share.log(flag: .verbose, message: message, file: file, function: function, line: line)
}
public func RealLogError(_ message: @autoclosure () -> Any?, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    RealLogger.share.log(flag: .error, message: message, file: file, function: function, line: line)
}

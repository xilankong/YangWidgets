//
//  RealLogFormatter.swift
//  Alamofire
//
//  Created by lbencs on 30/01/2018.
//

import Foundation
import CocoaLumberjack

class RealLogFormatter: NSObject, DDLogFormatter {
    func format(message logMessage: DDLogMessage) -> String? {
        return "\(logMessage.flag.description)||\(logMessage.fileName)->\(logMessage.function ?? "")||🍌\(logMessage.line)||👉\(logMessage.message)"
    }
}

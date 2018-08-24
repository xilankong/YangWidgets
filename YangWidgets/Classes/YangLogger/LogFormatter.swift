//
//  RealLogFormatter.swift
//
//  Created by yanghuang on 16/12/5.
//  Copyright © 2016年 yanghuang. All rights reserved.
//

import Foundation
import CocoaLumberjack

class LogFormatter: NSObject, DDLogFormatter {
    func format(message logMessage: DDLogMessage) -> String? {
        return "\(logMessage.flag.description)||\(logMessage.fileName)->\(logMessage.function ?? "")||🍌\(logMessage.line)||👉\(logMessage.message)"
    }
}

//
//  File.swift
//  YourLocal
//
//  Created by Dimitar Kostov on 1/19/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import Foundation

/**
 Debuger log, prints only one argument between sets of 3 dashes "--- @log ---", works only in Debug Mode, see Config.swift
 
 - parameter log: AnyObject
 */
public func DLOG(log: AnyObject) {
    if inDebug {
        print("--- ", log ," ---")
    }
}
//
//  SiftError.swift
//  Sift
//
//  Created by Obaid Ahmed Mohammed on 14/11/17.
//  Copyright © 2017 Shoutout Software. All rights reserved.
//

import Foundation

public enum SiftError: Error, Equatable {
    case KeyNotFound
    case NullValue
    case IncompatibleTypes(message: String)
    
    public static func ==(lhs: SiftError, rhs: SiftError) -> Bool {
        switch (lhs, rhs) {
        case (.KeyNotFound, .KeyNotFound):
            return true
        case (.NullValue, .NullValue):
            return true
        case (.IncompatibleTypes, .IncompatibleTypes):
            return true
        default:
            return false
        }
    }
}

//
//  SiftError.swift
//  Sift
//
//  Created by Obaid Ahmed Mohammed on 14/11/17.
//  Copyright © 2017 Shoutout Software. All rights reserved.
//

import Foundation

public class SiftError: Error {

    public let message: String

    init(message: String) {
        self.message = message
    }

}

extension SiftError: LocalizedError {

    public var errorDescription: String? {
        return NSLocalizedString(message, comment: "SiftError")
    }

}

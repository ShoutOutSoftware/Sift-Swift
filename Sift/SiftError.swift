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
    
    //We have to override both localized and error description to work around swift dispath rules
    //Check out https://forums.swift.org/t/confusing-error-localizeddescription-output/5337/3
    public var localizedDescription: String { return message }
    public var errorDescription: String? {return localizedDescription}
    
    init(message: String) {
        self.message = message
    }
    
}

extension SiftError: LocalizedError { }

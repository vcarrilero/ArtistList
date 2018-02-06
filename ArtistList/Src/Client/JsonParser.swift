//
//  JsonParser.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

enum ParserError: Error {
    
    case internalError
    case incorrectFormat
    case notImplemented
    case unknown
}

class JsonParser<T: Any> {
    
    let data: Data
    
    init(data: Data) {
        
        self.data = data
    }
    
    final func parse () throws -> T {
        
        if let json: [String: Any] = try JSONSerialization.jsonObject(with: self.data, options: [JSONSerialization.ReadingOptions.allowFragments]) as? [String: Any] {
            
            return try parseJson(json: json)
        } else {
            
            throw ParserError.incorrectFormat
        }
    }
    
    func parseJson(json: [String: Any] ) throws -> T {
        
        throw ParserError.notImplemented
    }
}

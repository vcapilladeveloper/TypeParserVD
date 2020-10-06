//
//  TypeParserVD.swift
//
//
//  Created by Victor Capilla Developer on 04/10/20.
//

import Foundation

enum ParseError: Error {
    case missingProperty
    case invalidType
}

public class TypeParserVD {
    
    static func getData<T: Codable>(from data: Data) throws -> T? {
        let actualError: NSError
        let decoder = JSONDecoder()
        var decodedData: T? = nil
        do {
            decodedData = try decoder.decode(T.self, from: data)
        } catch {
            actualError = error as NSError
            if actualError.code == 4864 {
                throw ParseError.invalidType
            } else if actualError.code == 4865 {
                throw ParseError.missingProperty
            }
        }
        return decodedData
    }
    
}

//
//  TypeParserVD.swift
//
//
//  Created by Victor Capilla Developer on 04/10/20.
//

import Foundation

public class TypeParserVD {
    
    public static func getData<T: Codable>(from data: Data) throws -> T? {
        let decoder = JSONDecoder()
        var decodedData: T? = nil
        do {
            decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw error as! DecodingError
        }
    }
    
    public static func getData<T: Codable>(from data: Data) -> Result<T, DecodingError> {
        let decoder = JSONDecoder()
        var decodedData: T
        do {
            decodedData = try decoder.decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error as! DecodingError)
        }
    }
    
}

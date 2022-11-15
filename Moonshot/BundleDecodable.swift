//
//  BundleDecodable.swift
//  Moonshot
//
//  Created by Roman on 11/10/22.
//

import Foundation

extension Bundle{
    func decode<T:Codable>(_ file: String) -> T{
        guard let url = self.url(forResource: file, withExtension: nil )
            else{
                fatalError("Failed to locate file \(file) in bundle")
            }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from")
        }
        
        let decoder = JSONDecoder()
        // When we decode Dates, reald them in this format
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        
        
        
        guard let loaded = try? decoder.decode(T.self, from: data)else {
            fatalError("Failed to decode file from bundel")
        }
        return loaded
       
    }
    
}

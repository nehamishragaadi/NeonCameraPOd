//
//  Serializable.swift
//  Neon-Ios
//
//  Created by Akhilendra Singh on 2/5/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import Foundation
protocol Serializable : Codable {
    func serialize() -> Data?
}

extension Serializable {
    func serialize() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
        
    }
}

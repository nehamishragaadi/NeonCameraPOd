//
//  INeutralParam.swift
//  Neon-Ios
//
//  Created by Akhilendra Chauhan on 07/02/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import Foundation
protocol INeutralParam : ICameraParam,IGalleryParam {
    func hasOnlyProfileTag() -> Bool
    func getProfileTagName() -> String
}

extension INeutralParam {
    func hasOnlyProfileTag() -> Bool {
        return false
    }
    
    func getProfileTagName() -> String {
        return "Profile Image"
    }
}

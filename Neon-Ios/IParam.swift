//
//  IParam.swift
//  Neon-Ios
//
//  Created by Akhilendra Chauhan on 07/02/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import Foundation
protocol IParam {
    func getNumberOfPhotos() -> Int
    func getTagEnabled() -> Bool
    func getImageTagsModel() -> [ImageTagModel]
    func getAlreadyAddedImages() -> [ImageTagModel]
    func enableImageEditing() -> Bool
    func getCustomParameters() -> CustomParameters
    
}



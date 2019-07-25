//
//  CameraModel.swift
//  Neon-Ios
//
//  Created by Akhilendra Chauhan on 08/02/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import Foundation

class CameraModel {
    func setParams(iParam : ICameraParam) -> PhotosModel{
        return PhotosModel(params : iParam)
    }
}

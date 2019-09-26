//
//  PhotosModel.swift
//  Neon-Ios
//
//  Created by Akhilendra Chauhan on 07/02/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import Foundation
class PhotosModel {
    var params : IParam
    
    init(params : IParam) {
        self.params = params
    }
    
    func getParams() -> IParam {
        return params
    }
    
    static func setGalleryMode() -> GalleryModel{
        return GalleryModel()
    }
    
    static func setCameraMode() -> CameraModel{
        return CameraModel()
    }
    
    static func setNeutralMode() -> NeutralModel{
        return NeutralModel()
    }
    
}

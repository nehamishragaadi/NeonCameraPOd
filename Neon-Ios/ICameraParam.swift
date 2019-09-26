//
//  ICameraParam.swift
//  Neon-Ios
//
//  Created by Akhilendra Chauhan on 07/02/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import Foundation

protocol ICameraParam : IParam {
    func getCameraFacing() -> CameraFacing
    func getCameraOrientation() -> CameraOrientation
    func getFlashEnabled() -> Bool
    func getCameraSwitchingEnabled() -> Bool
    func getVideoCaptureEnabled() -> Bool
    func getCameraViewType() -> CameraType
    func cameraToGallerySwitchEnabled() -> Bool
    
}

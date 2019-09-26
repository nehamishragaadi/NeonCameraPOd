//
//  IGalleryParam.swift
//  Neon-Ios
//
//  Created by Akhilendra Chauhan on 07/02/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import Foundation
protocol IGalleryParam : IParam {
    func selectVideos() -> Bool
    func getGalleryViewType() -> GalleryType
    func enableFolderStructure() -> Bool
    func galleryToCameraSwitchEnabled() -> Bool
    func isRestrictedExtensionJpgPngEnabled() -> Bool
}

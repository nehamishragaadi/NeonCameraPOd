//
//  LivePhotoNextTagListener.swift
//  Neon-Ios
//
//  Created by Akhilendra Chauhan on 08/02/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import Foundation
protocol LivePhotoNextTagListener {
    func updateExifInfo(fileInfo : FileInfo) -> Bool
    func onNextTag() -> Void
}

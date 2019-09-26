//
//  CustomParameters.swift
//  Neon-Ios
//
//  Created by Akhilendra Chauhan on 07/02/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import Foundation
class CustomParameters{
    private var hideCameraButtonInNeutral : Bool?
    private var hideGalleryButtonInNeutral : Bool?
    private var locationRestrictive : Bool?
    private var setCompressBy : Int?
    private var folderRestrictive : Bool?
    
    init(builder : CustomParametersBuilder) {
        
        self.hideCameraButtonInNeutral = builder.hideCameraButtonInNeutral
        self.hideGalleryButtonInNeutral = builder.hideGalleryButtonInNeutral
        self.locationRestrictive = builder.locationRestrictive
        self.setCompressBy = builder.setCompressBy
        self.folderRestrictive = builder.folderRestrictive
    }
    
    func gethideCameraButtonInNeutral() -> Bool {
        return hideCameraButtonInNeutral!
    }
    
    func getHideGalleryButtonInNeutral() -> Bool {
        return hideCameraButtonInNeutral!
    }
    
    func getLocationRestrictive() -> Bool {
        return locationRestrictive!
    }
    
    func getCompressBy() -> Int {
        return setCompressBy!
    }
    
    func getFolderRestrictive() -> Bool {
        return folderRestrictive!
    }
    
}

class CustomParametersBuilder{
    var hideCameraButtonInNeutral : Bool?
    var hideGalleryButtonInNeutral : Bool?
    var locationRestrictive : Bool?
    var setCompressBy : Int?
    var folderRestrictive : Bool?
    
    func sethideCameraButtonInNeutral(hide : Bool) -> CustomParametersBuilder {
        self.hideCameraButtonInNeutral = hide
        return self;
    }
    
    func setHideGalleryButtonInNeutral(hide : Bool) -> CustomParametersBuilder{
        self.hideGalleryButtonInNeutral = hide
        return self
    }
    
    func setLocationRestrictive(locationRestrictive : Bool) -> CustomParametersBuilder {
        self.locationRestrictive = locationRestrictive
        return self
    }
    
    func setCompressBy(setCompressBy : Int) -> CustomParametersBuilder {
        self.setCompressBy = setCompressBy
        return self
    }
    
    func setFolderRestrictive(folderRestrictive : Bool) -> CustomParametersBuilder {
        self.folderRestrictive = folderRestrictive
        return self
    }
    
    func build() -> CustomParameters {
        let user = CustomParameters(builder : self)
        return user
    }
    
}

//
//  NeonResponse.swift
//  Neon-Ios
//
//  Created by Akhilendra Chauhan on 08/02/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import Foundation

class NeonResponse{
    var imageTagsCollection : [String : [FileInfo]]!
    var imageCollection : [FileInfo]!
    var responseCode : ResponseCode!
    var requestCode : Int!
    
    func getImageTagsCollection() -> [String : [FileInfo]] {
        return imageTagsCollection
    }
    
    func getImageCollection() -> [FileInfo]{
        return imageCollection
    }
    
    func setImageCollection(imageCollection : [FileInfo]){
        self.imageCollection = imageCollection
    }
    
    func getResponseCode() -> ResponseCode{
        return responseCode
    }
    
    func setResponseCode(responseCode : ResponseCode){
        self.responseCode = responseCode
    }
    
    func getRequestCode() -> Int{
        return requestCode
    }
    
    func setRequestCode(requestCode : Int){
        self.requestCode = requestCode
    }
}

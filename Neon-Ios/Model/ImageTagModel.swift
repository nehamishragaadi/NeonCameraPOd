//
//  ImageTagModel.swift
//  Neon-Ios
//
//  Created by Akhilendra Singh on 1/30/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import Foundation
import CoreLocation
struct Coordinate: Codable{
    let latitude, longitude: String
}

class ImageTagModel : Codable{
    private var tagId : String?
    private var tagName : String?
    private var mandatory : Bool?
    private var noOfPhotos : Int?
    private var location : Coordinate?
    
    init(tagId : String,tagName : String, mandatory : Bool) {
        self.tagId = tagId
        self.tagName = tagName
        self.mandatory = mandatory
    }
    
    init(tagId : String,tagName : String, mandatory : Bool, noOfPhotos : Int) {
        self.tagId = tagId
        self.tagName = tagName
        self.mandatory = mandatory
        self.noOfPhotos = noOfPhotos
    }
    
    init(tagId : String,tagName : String, mandatory : Bool, noOfPhotos : Int, location : Coordinate) {
        self.tagId = tagId
        self.tagName = tagName
        self.mandatory = mandatory
        self.noOfPhotos = noOfPhotos
        self.location = location
    }
    
    public func getTagName() -> String {
        return self.tagName ?? "NA"
    }
    
    public func isMandatory() -> Bool{
        return mandatory!
    }
    
    public func getTagId() -> String{
        return tagId!
    }
    
    public func getNumberOfPhotos() -> Int{
        return noOfPhotos!
    }
    public func getloction() -> Coordinate{
        return location!
    }
    
    
    
    
    
}

extension CLLocationCoordinate2D {
    init(_ coordinate: Coordinate) {
        self.init(latitude: Double(coordinate.latitude)!, longitude: Double(coordinate.longitude)!)
    }
}

extension Coordinate {
    init(_ coordinate: CLLocationCoordinate2D) {
        self.init(latitude: String(coordinate.latitude), longitude: String(coordinate.longitude))
    }
}

//
//  FileInfo.swift
//  Neon-Ios
//
//  Created by Akhilendra Singh on 2/5/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import Foundation
enum FILE_TYPE : String, Codable{
    case IMAGE
    case FOLDER
}
enum SOURCE : String, Codable{
    case PHONE_CAMERA
    case PHONE_GALLERY
}
class FileInfo : Serializable {

    private var filePath : String?
    private var type : FILE_TYPE?
    private var fileName : String?
    private var displayName : String?
    private var selected : Bool?
    private var source : SOURCE?
    private var fileCount : Int?
    private var dateTimeTaken : String?
    private var fileTag : ImageTagModel?
    private var latitude : String?
    private var longitude : String?
    private var timestamp : String?
    
    public init()
    {
        self.selected = false
    }
    
    public init(filePath : String){
        self.filePath = filePath
        
    }
    
    public func isSelected() -> Bool {
        return selected!
    }
    
    public func setSelected(selected : Bool){
        self.selected = selected
    }
    
    public func getTimestamp() -> String{
        return timestamp!
    }
    
    public func setTimestamp(timestamp : String){
        self.timestamp = timestamp
    }
    
    public func getDateTimeTaken() -> String{
        return dateTimeTaken!
    }
    
    public func setDateTimeTaken(dateTimeTaken : String){
        self.dateTimeTaken = dateTimeTaken
    }
    
    public func getFileTag() -> ImageTagModel {
        return fileTag!
    }
    
    public func setFileTag(fileTag : ImageTagModel){
        self.fileTag = fileTag
    }
    
    public func getSource() -> SOURCE{
        return source!
    }
    
    public func setSource(source : SOURCE){
        self.source = source
    }
    
    public func getDisplayName() -> String{
        return displayName!
    }
    
    public func setDisplayName(displayName : String){
        self.displayName = displayName
    }
    
    public func getFilePath() -> String{
        return filePath!
    }
    
    public func setFilePath(filePath : String){
        self.filePath = filePath
    }
    
    public func getFileCount() -> Int{
        return fileCount!
    }
    
    public func setFileCount(fileCount : Int){
        self.fileCount = fileCount
    }
    
    public func getSelected() -> Bool{
        return selected!
    }
    
    public func getFileName() -> String{
        return fileName!
    }
    
    public func setFileName(fileName : String){
        self.fileName = fileName
    }
    
    public func getType() -> FILE_TYPE{
        return type!
    }
    
    public func setType(type : FILE_TYPE){
        self.type = type
    }
    
    public func getLongitude() -> String{
        return longitude!
    }
    
    public func setLongitude(longitude : String){
        self.longitude = longitude
    }
    
    public func getLatitude() -> String{
        return longitude!
    }
    
    public func setLatitude(latitude : String){
        self.latitude = latitude
    }
    

}

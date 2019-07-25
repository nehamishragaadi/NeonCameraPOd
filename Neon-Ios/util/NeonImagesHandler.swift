//
//  NeonImagesHandler.swift
//  Neon-Ios
//
//  Created by Akhilendra Chauhan on 08/02/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import Foundation
class NeonImagesHandler{
    static let singleonInstance = NeonImagesHandler()
    
    var clearInstance : Bool!
    var imagesCollection : [FileInfo] = []
    var cameraParam : ICameraParam!
    var galleryParam : IGalleryParam!
    var neutralEnabled : Bool!
    var neutralParam : INeutralParam!
    var imageResultListener : OnImageCollectionListener!
    var livePhotosListener : LivePhotosListener!
    var livePhotoNextTagListener : LivePhotoNextTagListener!
    var currentTag : String = ""
    var libraryMode : LibraryMode!
    var requestCode : Int!
    
    private init(){}
    
    public func getNumberOfPhotosCollected(imageTagModel : ImageTagModel) -> Int {
        var count : Int = 0
        if imagesCollection.count > 0 {
            for fileInfo in imagesCollection {
                
                if fileInfo.getFileTag() as? ImageTagModel == nil {
                    continue
                }
                if fileInfo.getFileTag().getTagId() == imageTagModel.getTagId() {
                   count += 1
                }
            }
        }
        
        return  count
    }
    
    public func getImageResultListener() -> OnImageCollectionListener {
        return imageResultListener
        
    }
    
    public func getLivePhotosListener() -> LivePhotosListener {
        return livePhotosListener
    }
    
    public func getLivePhotoNextTagListener() -> LivePhotoNextTagListener {
        return livePhotoNextTagListener
    }
    
    public func setLivePhotoNextTagListener(livePhotoNextTagListener : LivePhotoNextTagListener) -> Void {
        self.livePhotoNextTagListener = livePhotoNextTagListener
    }
    
    public func getCurrentTag() -> String {
        return currentTag
    }
    
    public func setCurrentTag(currentTag : String) -> Void {
        self.currentTag = currentTag
    }
    
    public func getGenericParam() -> IParam {
        if galleryParam != nil{
            return galleryParam;
        }
        else if cameraParam != nil {
            return cameraParam;
        }
        else {
            return neutralParam;
        }
    }
    
    public func isNeutralEnabled() -> Bool {
        return neutralEnabled
    }
    
    public func setNeutralEnabled(neutralEnabled : Bool) -> Void {
        self.neutralEnabled = neutralEnabled
    }
    
    public func getNeutralParam() -> INeutralParam {
        return neutralParam
    }
    
    public func setNeutralParam( neutralParam : INeutralParam) -> Void {
        self.neutralParam = neutralParam
    }
    
    public func getImagesCollection() -> [FileInfo] {
        return imagesCollection
    }
    
    public func setImagesCollection(allreadyAdded : [FileInfo]) -> Void {
        if allreadyAdded.count > 0 {
            for i in 0..<allreadyAdded.count {
                let cloneFile = FileInfo()
                let originalFile = allreadyAdded[i]
                
                if originalFile == nil {
                    continue
                }
                
                if originalFile.getFileTag() != nil {
                    cloneFile.setFileTag(fileTag: ImageTagModel(tagId : originalFile.getFileTag().getTagId(),tagName : originalFile.getFileTag().getTagName(), mandatory : originalFile.getFileTag().isMandatory(), noOfPhotos : originalFile.getFileTag().getNumberOfPhotos()))
                    
                    cloneFile.setSelected(selected: originalFile.getSelected());
                    cloneFile.setSource(source: originalFile.getSource());
                    cloneFile.setFileName(fileName: originalFile.getFileName());
                    cloneFile.setDateTimeTaken(dateTimeTaken: originalFile.getDateTimeTaken());
                    cloneFile.setDisplayName(displayName: originalFile.getDisplayName());
                    cloneFile.setFileCount(fileCount: originalFile.getFileCount());
                    cloneFile.setFilePath(filePath: originalFile.getFilePath());
                    cloneFile.setType(type: originalFile.getType());
                    imagesCollection.append(cloneFile)
                }
            }
        }
    }
    
    public func checkImagesAvailableForTag(tagModel : ImageTagModel) -> Bool {
        if imagesCollection.count <= 0 {
            return false;
        }
        for i in 0..<imagesCollection.count {
            if imagesCollection[i].getFileTag() != nil && imagesCollection[i].getFileTag().getTagId() == tagModel.getTagId() &&
        imagesCollection[i].getFileTag().getTagName() == tagModel.getTagName() {
                return true;
            }
        }
        return false
    }
    
    public func checkImageAvailableForPath(fileInfo : FileInfo) -> Bool {
        if imagesCollection.count <= 0 {
            return false;
        }
        for i in 0..<imagesCollection.count {
            if imagesCollection[i].getFilePath().lowercased() == fileInfo.getFilePath().lowercased() {
                return true;
            }
        }
        return false;
    }
    
    public func removeFromCollection(fileInfo : FileInfo) -> Bool {
        if imagesCollection.count <= 0 {
            return true;
        }
        for i in 0..<imagesCollection.count {
            if imagesCollection[i].getFilePath() == fileInfo.getFilePath() {
                return imagesCollection.remove(at: i) != nil
            }
        }
        return true;
    }
    
}

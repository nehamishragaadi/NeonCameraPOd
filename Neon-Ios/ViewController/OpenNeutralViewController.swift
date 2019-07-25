//
//  OpenNeutralViewController.swift
//  Neon-Ios
//
//  Created by Neha Mishra1 on 4/11/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import UIKit


class OpenNeutralViewController: UIViewController  {
//    func setImageArray(imageArray: [String : UIImage]) {
//        print("In set image array")
//        receivedArray = imageArray
//    }
    var tags: String = "Mandatory Tags\n\n"
    var nextVC : CameraViewController!
    var imageTagArray : [ImageTagModel] = []
    var receivedArray:[String:UIImage] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
//        imageTagArray.append(ImageTagModel(tagId: "1",tagName: "*Tag1",mandatory: true))
//        imageTagArray.append(ImageTagModel(tagId: "2",tagName: "*Tag2",mandatory: false))
//        imageTagArray.append(ImageTagModel(tagId: "3",tagName: "*Tag3",mandatory: true))
//
//        for tagModel in imageTagArray {
//            tags = tags + tagModel.getTagName() + "\n"
//        }
    }
    @IBAction func horizontalPriorityFileButonAction(_ sender: Any) {
    }
    @IBAction func horizontalOnlyFileButtonAction(_ sender: Any) {
    }
    
    @IBAction func horizontalPriorityButtonACtion(_ sender: Any) {
    }
    @IBAction func horizontalOnlyButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func gridPriorityFileButtonAction(_ sender: Any) {
    }
    @IBAction func gridOnlyFileButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func gridOnlyButtonAction(_ sender: Any) {
    }
    
    @IBAction func gridPriorityButtonAction(_ sender: Any) {
    }
    
    
    
    @IBAction func cameraOnlyButtonAction(_ sender: Any) {
     self.performSegue(withIdentifier: "CameraOnlyView", sender: self)
    }
    
    
    @IBAction func cameraPriorityButtonAction(_ sender: Any) {
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "showCameraFromFirstView"){
//            print("In segue")
//            let cameraVC = segue.destination as! CameraViewController
//            cameraVC.delegate = self
//            cameraVC.tagArray = imageTagArray
//        }
    }
}

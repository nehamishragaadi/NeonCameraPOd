//
//  CameraOnlyViewController.swift
//  Neon-Ios
//
//  Created by Neha Mishra1 on 4/11/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import UIKit


class CameraOnlyViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
   
    @IBOutlet weak var imageCollection: UICollectionView!
    var tags: String = "Mandatory Tags\n\n"
    var receivedArray:[String:UIImage] = [:]
    var imgArr: [UIImage] = [UIImage]()
    var imagePicker: UIImagePickerController!
    var gradePicker: UIPickerView!
    var tag_Value = 0
    let gradePickerValues = ["tag 0", "tag 1", "tag 2"]

    weak var imageTake: UIImageView!
    enum ImageSource {
        case photoLibrary
        case camera
    }
    @IBAction func saveButtonAction(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradePicker = UIPickerView()
        gradePicker.dataSource = self
        gradePicker.delegate = self
    }
    //pickerview
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return gradePickerValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gradePickerValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let section = tag_Value / 100
        let item = tag_Value % 100
        let indexPath = IndexPath(item: item, section: section)
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "SelectImgCameraCell", for: indexPath as IndexPath) as! SelectImgCameraCollectionViewCell
        cell.tag_Name.text = gradePickerValues[row]

        self.view.endEditing(true)
    }
    
    @IBAction func openCameraButtonACtion(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(.camera)
    }
    
    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
   
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
           
            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    
    // collection view

    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "SelectImgCameraCell", for: indexPath as IndexPath) as! SelectImgCameraCollectionViewCell
        cell.backgroundColor = UIColor.black
        cell.tag_Name.tag = (indexPath.section * 100) + indexPath.item
        tag_Value = cell.tag_Name.tag
        if  self.imgArr.count > 0 {
        cell.selectImage.image =  self.imgArr[indexPath.row]
            
        }
        return cell
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.imgArr.count)
        if  self.imgArr.count > 0 {
        return  self.imgArr.count
        }else{
            return 0
        }
    }
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell : SelectImgCameraCollectionViewCell = imageCollection.cellForItem(at: indexPath as IndexPath) as! SelectImgCameraCollectionViewCell
        cell.backgroundColor = UIColor.magenta
        cell.tag_Name.tag = indexPath.row
        cell.tag_Name.inputView = gradePicker
    }
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                                
                                sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 90, height: 90)
        
        
        
    }
    
}

extension CameraOnlyViewController: UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        
       // imageTake.image = selectedImage
        self.imgArr.append(selectedImage)
        self.imageCollection.reloadData()
    }
}
    

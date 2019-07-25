//
//  ViewController.swift
//  Neon-Ios
//
//  Created by Akhilendra Singh on 1/16/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import UIKit
import Photos
import OpalImagePicker


class ViewController: UIViewController, MyProtocol,UICollectionViewDelegate, UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource , UITextFieldDelegate {
   
    var receivedArray:[String:UIImage] = [:]
    var recievedImgArr:[UIImage] = [UIImage]()
    var nextVC : CameraViewController!
    var imageCounter: Int = 0
    var tags: String = "Mandatory Tags\n\n"
    var imageTagArray : [ImageTagModel] = []
    var finalDict: [[String : Any]] = [[String : Any]]()
    var dict : [String:Any] = [String:Any] ()
    var locArr : [CLLocation] = [CLLocation]()

    @IBOutlet weak var tagListView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imagePicker: UIImagePickerController!
    var gradePicker: UIPickerView!
    var tag_Value = 0
    var tag_Id = 0

    var type = ""
    var gradePickerValues = ["tag 0", "tag 1", "tag 2"]
    var selected: String {
        return UserDefaults.standard.string(forKey: "selected") ?? ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageTagArray.append(ImageTagModel(tagId: "1",tagName: "*Tag1",mandatory: true))
        imageTagArray.append(ImageTagModel(tagId: "2",tagName: "*Tag2",mandatory: false))
        imageTagArray.append(ImageTagModel(tagId: "3",tagName: "*Tag3",mandatory: true))
        
        for tagModel in imageTagArray {
            tags = tags + tagModel.getTagName() + "\n"
        }
        self.tagListView.text = tags
        gradePicker = UIPickerView()
        gradePicker.dataSource = self
        gradePicker.delegate = self
        if let row = self.gradePickerValues.firstIndex(of: selected) {
            gradePicker.selectRow(row, inComponent: 0, animated: false)
        }

//        let ll = GetLocation()
//        print("Location")
//        ll.getLocation()
    }
   
    //pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return gradePickerValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gradePickerValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let section = self.tag_Value / 100
        let item = self.tag_Value % 100
        let indexPath = IndexPath(item: item, section: section)
        let cell = collectionView.cellForItem(at: indexPath)! as! MyImageCell
        cell.tagName.text! = String(gradePickerValues[row])
        UserDefaults.standard.set(gradePickerValues[row], forKey: "selected")

        self.view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
        guard let cell = textField.superview?.superview as? MyImageCell else {
            return
        }
        let indexPath = collectionView.indexPath(for: cell) as! IndexPath
        tag_Value = indexPath.row
    }
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "CameraViewController"){
            
            print("In segue")
            
            let cameraVC = segue.destination as! CameraViewController
            cameraVC.delegate = self
            
            
            cameraVC.tagArray = imageTagArray
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 3. Before displaying the value check if it contains data
        if receivedArray.count > 0      {
            print(receivedArray)
            tagListView.isHidden = true
            collectionView.isHidden = false
            collectionView.reloadData()
        }
        else{
            print("hi2")
        }
    }
    
    @IBAction func cameraButtonAction(_ sender: Any) {
        
        self.type = "camera"
    }
    
    func getCellsData() -> [[String:Any]] {
        for section in 0 ..< self.collectionView.numberOfSections {
            for row in 0 ..< self.collectionView.numberOfItems(inSection: section) {
                let indexPath = NSIndexPath(row: row, section: section)
                let cell = self.collectionView.cellForItem(at: indexPath as IndexPath) as! MyImageCell
                let filePath = self.documentsPathForFileName(name:  (cell.imageView.image?.toString())!)
//                let imageData: NSData = cell.imageView.image!.pngData()! as NSData
//                imageData.write(toFile: filePath, atomically: true)
                let img_Url = NSURL(string: filePath)
                if self.type == "camera" {
               dict["location"] = self.locArr[indexPath.row]
                }
               dict["tag_Name"] = cell.tagName.text
               dict["Image_url"] = img_Url
              self.finalDict.append(dict)
            }
        }
        print("== final Dict",self.finalDict.count,self.finalDict)
        let alert = UIAlertController(title: "Alert", message: String(describing: self.finalDict) , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return self.finalDict
    }
    func documentsPathForFileName(name: String) -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return documentsPath.appending(name)
    }
    @IBAction func submitButtonAction(_ sender: Any) {
        
        self.getCellsData()
    }
    
    
    @IBAction func openGalleryTap(_ sender: Any) {
        self.type = "gallery"
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = OpalImagePickerController()
            imagePicker.imagePickerDelegate = self
            imagePicker.maximumSelectionsAllowed = imageTagArray.count
           
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)
            
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            let data = image.pngData()! as NSData
            data.write(toFile: localPath!, atomically: true)
            //let imageData = NSData(contentsOfFile: localPath!)!
            let photoURL = URL.init(fileURLWithPath: localPath!)//NSURL(fileURLWithPath: localPath!)
            print(photoURL)
            
        }
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        print(selectedImage)
        UIImageWriteToSavedPhotosAlbum(selectedImage , self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

    
        dismiss(animated: true, completion: nil)
    }
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    

    func setImageArray(imageArray: [String:UIImage]) {
        print("In set image array")
        receivedArray = imageArray
    }
    func setImageLoc(location: [CLLocation]){
        self.locArr = location
    }

    // collection view
    
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! MyImageCell
        
        cell.backgroundColor = UIColor.black
        
        var currImage:UIImage!
        var tagName: String!
        let keyArray = Array(receivedArray.keys)
        tagName = keyArray[imageCounter]
        //currImage = self.recievedImgArr[keyArray[imageCounter]]
        currImage = self.recievedImgArr[indexPath.row]

        print("imageCounter",imageCounter)
        
        self.imageCounter += 1
        if self.imageCounter >= self.receivedArray.count {
            self.imageCounter = 0
        }
        //tag_Value = indexPath.row
        gradePicker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
        gradePicker.delegate = self
        gradePicker.dataSource = self
       // gradePicker.backgroundColor = .white
       // gradePicker.showsSelectionIndicator = true
        
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
     
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ViewController.doneTapped))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        cell.tagName.inputAccessoryView = toolBar
        cell.tagName.inputView = gradePicker
        cell.imageView.image = currImage
        cell.tagName.text = tagName
        cell.deleteButton?.tag = indexPath.row
        cell.deleteButton?.addTarget(self, action: #selector(deletePicture(sender:)), for: UIControl.Event.touchUpInside)

        return cell
    }
    @objc func deletePicture(sender:UIButton) {
        let i : Int = Int(sender.tag)
        recievedImgArr.remove(at: i)

        collectionView.reloadData()
    }
    @objc func doneTapped(sender: Any) {
        self.view.endEditing(true)
    }
  
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell : MyImageCell = collectionView.cellForItem(at: indexPath as IndexPath) as! MyImageCell
        print(indexPath.row)
      //  tag_Value = indexPath.row + 200
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("receivedArray",receivedArray)
        return recievedImgArr.count
    }
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
        }

}

extension ViewController: OpalImagePickerControllerDelegate {
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        //Cancel action?
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        //Save Images, update UI
        for i in 0...images.count-1 {
        recievedImgArr.append(images[i])
        receivedArray[imageTagArray[i].getTagName()] = images[i]
        print("i",i,recievedImgArr)
        }
        collectionView.reloadData()
        //Dismiss Controller
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerNumberOfExternalItems(_ picker: OpalImagePickerController) -> Int {
        return 1
    }
    
    func imagePickerTitleForExternalItems(_ picker: OpalImagePickerController) -> String {
        return NSLocalizedString("External", comment: "External (title for UISegmentedControl)")
    }
    
    func imagePicker(_ picker: OpalImagePickerController, imageURLforExternalItemAtIndex index: Int) -> URL? {
        return URL(string: "https://placeimg.com/500/500/nature")
    }
}
extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}

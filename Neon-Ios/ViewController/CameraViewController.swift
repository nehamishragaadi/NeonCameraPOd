//
//  CameraViewController.swift
//  Neon-Ios
//
//  Created by Akhilendra Singh on 1/17/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit

protocol MyProtocol : class {
    func setImageArray(imageArray: [String:UIImage])
    func setImageLoc(location: [CLLocation])
    
}

class CameraViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate  {
    weak var delegate:MyProtocol?
    
    
    var tagArray : [ImageTagModel] = []
    
    
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var tagTextView: UITextView!
    @IBOutlet weak var currentImageClicked: UIImageView!
    
    @IBOutlet weak var preview: UIView!
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var input: AVCaptureInput!
    var currentCamera: AVCaptureDevice!
    var currentFlashMode: FlashMode!
    var currentSettings: AVCapturePhotoSettings? = nil
    var imageArray: [String:UIImage] = [:]
    var isFlashOnOff : Bool = false
    private var cameraPosition: CameraFacing = .back
    private var deviceInput: AVCaptureDeviceInput?
    var tagIndex : Int = 0;
    var currentLocation: CLLocation!
    var loc_Array: [CLLocation] = [CLLocation]()
    var locManager = CLLocationManager()
   

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        print("Tag::"+tagArray[0].getTagName())
          self.tagTextView.text = tagArray[0].getTagName()
          self.setupCamera(position: .back)
          self.checkIndex()
        
    }
    
    func setupCamera(position: AVCaptureDevice.Position){
        // Setup your camera here...
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        //var input:Any
        
        guard let device: AVCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                                    for: .video, position: position) else { return }
        
        currentCamera = device
        currentFlashMode = .auto
        
        
        
        do {
            input = try AVCaptureDeviceInput(device: device)
            //Step 9
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        stillImageOutput = AVCapturePhotoOutput()
        if captureSession.canAddInput(input ) && captureSession.canAddOutput(stillImageOutput) {
            captureSession.addInput(input )
            captureSession.addOutput(stillImageOutput)
            setupLivePreview()
        }
        
    }
    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        preview.layer.addSublayer(videoPreviewLayer)
        
        //Step12
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            //Step 13
        }
        DispatchQueue.main.async {
            self.videoPreviewLayer.frame = self.preview.bounds
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func takePhoto(_ sender: Any) {
        currentSettings = getSettings(camera: currentCamera,isFlashOnOff : isFlashOnOff)
        stillImageOutput.capturePhoto(with: currentSettings!, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        var tagModel : ImageTagModel = self.tagArray[tagIndex]
        let image = UIImage(data: imageData)
        currentImageClicked.image = image
        imageArray[tagModel.getTagName()] = image
        print("Test: ",image ?? "No Value");
        UIImageWriteToSavedPhotosAlbum(image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        if tagIndex < tagArray.count-1 {
        tagIndex = tagIndex + 1;
        tagModel = self.tagArray[tagIndex]
        self.tagTextView.text = tagModel.getTagName();
        }
        
        
        self.checkIndex()
    


    }
    
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "The screenshot has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        locManager.requestWhenInUseAuthorization()
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locManager.location
            
        }
        print(",longitude","\(currentLocation.coordinate.longitude)")
        print("latitude","\(currentLocation.coordinate.latitude)")
        self.loc_Array.append(currentLocation)
    }
    
    @IBAction func tapToDone(_ sender: Any) {
        delegate?.setImageArray(imageArray: imageArray)
        delegate?.setImageLoc(location: self.loc_Array)
        print("hello",imageArray.count)
        print("location = ",self.loc_Array)
        //dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapOnCameraSwitch(_ sender: UITapGestureRecognizer) {
        print("tapped camera switch")
        
        switch self.cameraPosition {
        case .front:
            self.cameraPosition = .back
            self.setupCamera(position: .back)
        case .back:
            self.cameraPosition = .front
            self.setupCamera(position: .front)
        }
        //configure your session here
       /* DispatchQueue.main.async {
            self.captureSession.beginConfiguration()
            if self.captureSession.canAddOutput(self.stillImageOutput) {
                self.captureSession.addOutput(self.stillImageOutput)
            }
            self.captureSession.commitConfiguration()
        }*/
    }
    
    @IBAction func tapFlashOnOff(_ sender: UITapGestureRecognizer) {
        isFlashOnOff = isFlashOnOff ? false:true
    }
    
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        print("previous tapped")
        
        if tagIndex > 0 {
            tagIndex = tagIndex - 1;
            let tagModel : ImageTagModel = self.tagArray[tagIndex]
            self.tagTextView.text = tagModel.getTagName();
        }
        self.checkIndex()
    }
    
    func checkIndex(){
        if tagIndex == 0 {
            previousButton.isHidden = true
        }
        else if tagIndex > 0 && tagIndex < tagArray.count-1 {
            previousButton.isHidden = false
            nextButton.isHidden = false
        }
        else if tagIndex == tagArray.count-1{
            nextButton.isHidden = true
        }
        
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        print("next Tapped")
        
        if tagIndex < tagArray.count-1 {
            tagIndex = tagIndex + 1;
            let tagModel : ImageTagModel = self.tagArray[tagIndex]
            self.tagTextView.text = tagModel.getTagName();
        }
        self.checkIndex()
        
    }
    func getSettings(camera: AVCaptureDevice, isFlashOnOff: Bool) -> AVCapturePhotoSettings {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        
        if camera.hasFlash {
            /*switch flashMode {
            case .auto: settings.flashMode = .auto
            case .on: settings.flashMode = .on
            default: settings.flashMode = .off
            }*/
            if(isFlashOnOff){
                settings.flashMode = .on
            }
            else{
               settings.flashMode = .off
            }
          /*  if settings.flashMode == .on {
                
            }
            else{
                
            }*/
        }
        print("Test:",settings)
        return settings
    }

    func addVideoInput(position: AVCaptureDevice.Position) {
        guard let device: AVCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                                    for: .video, position: position) else { return }
        if let currentInput = self.deviceInput {
            self.captureSession.removeInput(currentInput)
            self.deviceInput = nil
        }
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if self.captureSession.canAddInput(input) {
                self.captureSession.addInput(input)
                self.deviceInput = input
            }
        } catch {
            print(error)
        }
    }

    
}

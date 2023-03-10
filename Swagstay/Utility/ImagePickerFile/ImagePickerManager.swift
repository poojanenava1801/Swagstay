////
////  ImagePickerManager.swift
////  PickPic
////
////  Created by mac on 15/10/20.
////
//
//import Foundation
//import UIKit
//import PhotosUI
//import MobileCoreServices
//
//
//class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate,PHPickerViewControllerDelegate {
//
//    var picker = UIImagePickerController();
//    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
//    var viewController: UIViewController?
//    var pickImageCallback : ((UIImage?,URL?) -> ())?;
//    var isShowRecording = false
//
//    override init(){
//        super.init()
//    }
//
//    func pickImage(_ viewController: UIViewController, _ callbackImage: @escaping ((UIImage?,URL?) -> ())) {
//        pickImageCallback = callbackImage;
//        self.viewController = viewController;
//
////        let cameraAction = UIAlertAction(title: "Camera", style: .default){
////            UIAlertAction in
////            self.openCamera()
////        }
////        let recordingAction = UIAlertAction(title: "Recording", style: .default){
////            UIAlertAction in
//            self.openVideo()
////        }
////        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
////            UIAlertAction in
////        }
//
//        // Add the actions
//        picker.delegate = self
//        picker.allowsEditing = true
//   //     alert.addAction(cameraAction)
//
//     //   if isShowRecording == true{
//   //         alert.addAction(recordingAction)
//      //  }
//  //
//  //      alert.addAction(cancelAction)
//   //     alert.popoverPresentationController?.sourceView = self.viewController!.view
//    //    viewController.present(alert, animated: true, completion: nil)
//    }
//
//
//    func openCamera(){
//        //     alert.dismiss(animated: true, completion: nil)
//        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
//            picker.sourceType = .camera
//
//            self.viewController!.present(picker, animated: true, completion: nil)
//        } else {
//            let alert = UIAlertController(title: "Warning", message:"You don't have camera", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
//            self.viewController!.present(alert, animated: true){}
//
//            //            let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
//            //            alertWarning.show()z
//        }
//    }
//
//    func openVideo(){
//        //     alert.dismiss(animated: true, completion: nil)
//  //      if(UIImagePickerController .isSourceTypeAvailable(.camera)){
//            picker.sourceType = .savedPhotosAlbum
//            picker.mediaTypes = [kUTTypeMovie as String]
//            picker.delegate = self
//         //   picker.videoMaximumDuration = 5
//
//            self.viewController!.present(picker, animated: true, completion: nil)
////        } else {
////            let alert = UIAlertController(title: "Warning", message:"You don't have camera", preferredStyle: .alert)
////            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
////            self.viewController!.present(alert, animated: true){}
//
//            //            let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
//            //            alertWarning.show()z
//  //      }
//    }
//
//    func openGallery(){
//        if #available(iOS 14, *)
//        {
//            var configuration = PHPickerConfiguration()
//            configuration.filter = .images
//            configuration.selectionLimit = 0
//            let picker = PHPickerViewController(configuration: configuration)
//            picker.delegate = self
//            viewController!.present(picker, animated: true, completion: nil)
//        }else{
//            alert.dismiss(animated: true, completion: nil)
//            picker.sourceType = .photoLibrary
//            self.viewController!.present(picker, animated: true, completion: nil)
//        }
//    }
//
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//    //for swift below 4.2
//    //func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//    //    picker.dismiss(animated: true, completion: nil)
//    //    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//    //    pickImageCallback?(image)
//    //}
//
//    //VideoHelper.startMediaBrowser(delegate: self, sourceType: .savedPhotosAlbum)
//
//    // For Swift 4.2+
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//
//
//
//        if let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL{
//            guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
//                  mediaType == (kUTTypeMovie as String),
//                  let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) else {  return }
//
//            pickImageCallback?(nil, url)
//
//            UISaveVideoAtPathToSavedPhotosAlbum(url.path,self,#selector(video(_:didFinishSavingWithError:contextInfo:)),
//                                                nil)
//
//        }else{
//            guard let image = info[.editedImage] as? UIImage else {
//                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
//            }
//            pickImageCallback?(image, nil)
//        }
//        //        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
//        //            mediaType == (kUTTypeMovie as String),
//        //        let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) else { return }
//        //
//        //        UISaveVideoAtPathToSavedPhotosAlbum(url.path,self,#selector(video(_:didFinishSavingWithError:contextInfo:)),
//        //            nil)
//    }
//
//    @objc func video(_ videoPath: String,didFinishSavingWithError error: Error?,contextInfo info: AnyObject) {
//        let title = (error == nil) ? "Success" : "Error"
//        let message = (error == nil) ? "Video was saved" : "Video failed to save"
//
//        let alert = UIAlertController(title: title,message: message,preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK",style: UIAlertAction.Style.cancel,handler: nil))
//   //     self.viewController!.present(picker, animated: true, completion: nil)
//    }
//
//
//    @available(iOS 14, *)
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult])
//    {
//        picker.dismiss(animated: true, completion: nil)
//        for result in results
//        {
//            result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
//                if let image = object as? UIImage {
//                    DispatchQueue.main.async {
//                        // Use UIImage
//                        print("Selected image: \(image)")
//                        self.pickImageCallback?(image, nil)
//                    }
//                }else{
//                    if let url = object as? URL{
//
//                        DispatchQueue.main.async {
//                            // Use URL
//                            print("Selected URL: \(url)")
//                            self.pickImageCallback?(nil, url)
//                        }
//                    }
//                }
//            })
//        }
//    }
//
//    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
//    }
//
//}



// MARK: OldPicker



import Foundation
import UIKit
import PhotosUI
import MobileCoreServices

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate,PHPickerViewControllerDelegate {
    
    var picker = UIImagePickerController();
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage?,URL?,String?) -> ())?;
    var isShowRecording = false
    
    override init(){
        super.init()
    }
    
    func pickImage(_ viewController: UIViewController, _ callbackImage: @escaping ((UIImage?,URL?,String?) -> ())) {
        pickImageCallback = callbackImage;
        self.viewController = viewController;
        
         // self.openGallery()
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
       
        
        let openGallery = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        picker.allowsEditing = true
      //  alert.addAction(cameraAction)
        
     //   if isShowRecording == true{
            alert.addAction(openGallery)
        alert.addAction(cameraAction)
      //  }
        
     //   alert.addAction(removeImgAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
    }
    
//    func pickImage1(_ viewController: UIViewController, _ callbackImage: @escaping ((UIImage?,URL?) -> ())) {
//        pickImageCallback = callbackImage;
//        self.viewController = viewController;
//
//       // self.openGallery()
//        let cameraAction = UIAlertAction(title: "Camera", style: .default){
//            UIAlertAction in
//            self.openGallery()
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
//            UIAlertAction in
//        }
//
//        // Add the actions
//        picker.delegate = self
//        picker.allowsEditing = true
//   //     alert.addAction(cameraAction)
//
//     //   if isShowRecording == true{
//            //alert.addAction(recordingAction)
//      //  }
//
//  //      alert.addAction(cancelAction)
//        alert.popoverPresentationController?.sourceView = self.viewController!.view
//        viewController.present(alert, animated: true, completion: nil)
//    }
    
    func openCamera(){
        //     alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message:"You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.viewController!.present(alert, animated: true){}
            
            //            let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
            //            alertWarning.show()z
        }
    }
    
    func removeImage(){
        pickImageCallback?(nil, nil,"removed")
      //  alert.dismiss(animated: true, completion: nil)
       // self.viewController!.present(picker, animated: true, completion: nil)
    }
    
    
//    func editProfileApi(){
//        showHud()
//        let param = ["name":tfUser.text ?? "" ,"username":tfUserName.text ?? "","bio":tfBio.text ?? "","location": tfLocation.text ?? "","redemption_address":tfAddress.text ?? "","latitude":latitude ?? 0,"longitude":longitude ?? 0] as [String : Any]
//        print(param)
//
//        HttpUtility.shared.postApiForEditProfileHeaderWithImageDataJson(requestUrl: AppUrl.UpdateProfile, param: param, images: imgUplaod) { data in
//            print(data)
//            hideHud()
//            self.navigationController?.popViewController(animated: true)
//        }
//    }
    
    func openGallery(){
//        if #available(iOS 14, *)
//        {
//            var configuration = PHPickerConfiguration()
//            configuration.filter = .images
//            configuration.selectionLimit = 0
//         //   let picker = PHPickerViewController(configuration: configuration)
//            picker.sourceType = .savedPhotosAlbum
//            picker.mediaTypes = [kUTTypeMovie as String]
//            picker.delegate = self
//            viewController!.present(picker, animated: true, completion: nil)
//        }else{
            alert.dismiss(animated: true, completion: nil)
        //    picker.sourceType = .photoLibrary
            picker.sourceType = .savedPhotosAlbum
           // picker.mediaTypes = [kUTTypeImage as String]
           picker.mediaTypes = ["public.image"]
            self.viewController!.present(picker, animated: true, completion: nil)
  //      }
    }
    
    func openVideo(){
        //     alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            picker.mediaTypes = [kUTTypeMovie as String]
            picker.delegate = self
           picker.videoMaximumDuration = 5
                
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message:"You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.viewController!.present(alert, animated: true){}
            
            //            let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
            //            alertWarning.show()z
        }
    }
    
    
    

    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    //for swift below 4.2
    //func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    //    picker.dismiss(animated: true, completion: nil)
    //    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    //    pickImageCallback?(image)
    //}
    
    //VideoHelper.startMediaBrowser(delegate: self, sourceType: .savedPhotosAlbum)
    
    // For Swift 4.2+
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
                
        if info[UIImagePickerController.InfoKey.mediaURL] is URL{
            guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
                  mediaType == (kUTTypeMovie as String),
                  let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) else {  return }
            
            pickImageCallback?(nil, url, nil)
            
            UISaveVideoAtPathToSavedPhotosAlbum(url.path,self,#selector(video(_:didFinishSavingWithError:contextInfo:)),
                                                nil)
            
        }else{
            guard let image = info[.editedImage] as? UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
            pickImageCallback?(image, nil, nil)
        }
        //        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
        //            mediaType == (kUTTypeMovie as String),
        //        let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) else { return }
        //
        //        UISaveVideoAtPathToSavedPhotosAlbum(url.path,self,#selector(video(_:didFinishSavingWithError:contextInfo:)),
        //            nil)
    }
    
    @objc func video(_ videoPath: String,didFinishSavingWithError error: Error?,contextInfo info: AnyObject) {
        let title = (error == nil) ? "Success" : "Error"
        let message = (error == nil) ? "Video was saved" : "Video failed to save"
        
        let alert = UIAlertController(title: title,message: message,preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",style: UIAlertAction.Style.cancel,handler: nil))
   //     self.viewController!.present(picker, animated: true, completion: nil)
    }
    
    
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult])
    {
        picker.dismiss(animated: true, completion: nil)
        for result in results
        {
            result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self.pickImageCallback?(image, nil, nil)
                    }
                }else{
                    if let url = object as? URL{
                        DispatchQueue.main.async {
                            self.pickImageCallback?(nil, url, nil)
                        }
                    }
                }
            })
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }
    
}

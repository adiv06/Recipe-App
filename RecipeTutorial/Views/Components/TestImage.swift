//
//  TestImage.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 7/6/23.
//

import Foundation
import AVFoundation
import UIKit
import SwiftUI

/*
class TestImage: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) -> UIImagePickerController{
        cameraButtonTap()
    }
    
    override func viewDidLoad() {
        
        //do something
        super.viewDidLoad()
        
    }
    
    
    public func cameraButtonTap() -> UIImagePickerController{
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        //present(picker, animated: true)
        return picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        RecipesViewModel().imageSearchPictures.append(info[UIImagePickerController.InfoKey.editedImage] as! UIImage)
        picker.dismiss(animated: true)
    }
}
 */

//MARK: Other Image Taking Method

struct newImageView: UIViewControllerRepresentable{
    @Environment(\.dismiss) var dismiss
    
    func makeUIViewController(context: Context) -> UIViewController {
        //var createPicker = false
        /*switch AVCaptureDevice.authorizationStatus(for: .video)
        {
        case .authorized, .notDetermined:
            createPicker = true
        default:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {(granted: Bool) in
                        if granted {
                            createPicker = true
                        }else{
                            IngredientResultDisplay.settings = true
                        }
                    })
             
            //IngredientResultDisplay.settings = true
        }*/
        
        if(true)
        {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.allowsEditing = true
            picker.delegate = context.coordinator //can recieve events
            return picker
        }
        else{
            return makeUIViewController(context: context)
        }

            
    }
    /*
    func alertPromptToAllowCameraAccessViaSetting(){
        let alert = UIAlertController(title: "Error", message: "Camera access required for scanning", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Settings", style: .cancel) { (alert) -> Void in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        })
            self.present(alert, animated: true)
    }
    */
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        //
        
    }
    
    func makeCoordinator() -> (Coordinator) {
        return Coordinator()
    }
    //typealias UIViewControllerType = UIViewController
    
    
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Run code when user cancels UI
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Run code when user has selected image
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            fatalError("Could not assign image taken to selected image")
        }
        RecipesViewModel.imageSearchPictures.append(selectedImage)
        UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
        picker.dismiss(animated: true)
    }
}

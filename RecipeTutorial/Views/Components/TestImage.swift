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

//MARK: Other Image Method

struct newImageView: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> UIViewController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = context.coordinator //can recive events
        return picker
    }
    
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
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Run code when user has selected image
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            fatalError("Could not assign image taken to selected image")
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
         
    }
}

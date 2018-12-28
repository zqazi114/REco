//
//  RecoViewController.swift
//  REco
//
//  Created by Dev Macbook on 12/27/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import UIKit

class RecoViewController: ViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var recoModel: RecoModel?
    var recoView: RecoView?
    
    func performReco() {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            recoView!.updateImage(image: image)
            
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        
        recoModel = RecoModel(controller: self)
        recoView = RecoView(controller: self, mainView: self.view)
        
    }
    
}

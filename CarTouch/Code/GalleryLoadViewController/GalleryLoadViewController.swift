//
//  GalleryLoadViewController.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 10.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class GalleryLoadViewController: UIViewController {
    
    // MARK: - Properties
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Actions
    
    @IBAction func getImageAction(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        
        self.present(imagePicker, animated: true, completion: nil)
        //self.navigationController?.pushViewController(imagePicker, animated: true)
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension GalleryLoadViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // when take photo
        
        //print(info)
        
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

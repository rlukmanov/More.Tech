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
    let sourceType: UIImagePickerController.SourceType = .savedPhotosAlbum
    var isFound = false
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var getImageButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var loadButtonTitle: UILabel!
    @IBOutlet weak var searchButton: CustomButton!
    @IBOutlet weak var subActionImageView: UIImageView!
    
    // MARK: - Actions
    
    @IBAction func subAction(_ sender: Any) {
        if isFound {
            defaultSet()
        } else {
            imagePicker.sourceType = sourceType
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func getImageAction(_ sender: Any) {
        imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        defaultSet()
    }
    
    // MARK: - Set Properties
    
    private func defaultSet() {
        imageView.image = nil
        loadButtonTitle.text = "Для загрузки фото нажмите на меня"
        descriptionLabel.text = "Загрузите фотографию автомобиля"
        searchButton.isEnabled = false
        searchButton.layer.backgroundColor = UIColor(red: 213.0 / 255.0, green: 216.0 / 255.0, blue: 223.0 / 255.0, alpha: 1.0).cgColor
        subActionImageView.image = UIImage(named: "Add")
        isFound = false
    }
    
    private func foundSet(image: UIImage) {
        imageView.image = image
        loadButtonTitle.text = ""
        descriptionLabel.text = "Для выбора другой фотографии нажмите на область с текущим фото"
        searchButton.isEnabled = true
        searchButton.layer.backgroundColor = UIColor(red: 58.0 / 255.0, green: 131.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0).cgColor
        subActionImageView.image = UIImage(named: "Delete")
        isFound = true
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension GalleryLoadViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        foundSet(image: info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

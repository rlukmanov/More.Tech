//
//  PersonalCabViewController.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 10.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class PersonalCabViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var familyTextField: UITextField!
    @IBOutlet weak var middleTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var incomeTextField: UITextField!
    
    @IBOutlet weak var manButton: RadioButton!
    @IBOutlet weak var womanButton: RadioButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var bottomConstraintScrollView = NSLayoutConstraint()
    var defaultBottomOffset: CGFloat = -374
    var bottomMaxOffset: CGFloat = -374 + 2 * 31 + 55
    
    // MARK: - Action
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomConstraintScrollView = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultBottomOffset)
        bottomConstraintScrollView.isActive = true
        
        // Get height keyboard
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        nameTextField.delegate = self
        familyTextField.delegate = self
        middleTextField.delegate = self
        numberTextField.delegate = self
        emailTextField.delegate = self
        incomeTextField.delegate = self
        
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)
        
        manButton.isSelected = true
        womanButton.isSelected = false
        
        manButton.alternateButton = [womanButton!]
        womanButton.alternateButton = [manButton!]
    }
    
    // MARK: - Animate function
    
    func animateScrollUp() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.bottomConstraintScrollView.constant = self.bottomMaxOffset
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func animateScrollDown() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.bottomConstraintScrollView.constant = self.defaultBottomOffset
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // MARK: - KeyboardWillShow
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            bottomMaxOffset = -bottomMaxOffset - keyboardHeight + defaultBottomOffset
            
            animateScrollUp()
        }
    }
    
    // MARK: - DismissKeyboard
    
    @objc
    func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension PersonalCabViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        userText.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        bottomMaxOffset = -374 + 2 * 31 + 55
        animateScrollDown()
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

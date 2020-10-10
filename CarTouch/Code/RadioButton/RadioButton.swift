//
//  CheckBox.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 10.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class RadioButton: UIButton {
    let colorSelected = UIColor(red: 58.0 / 255.0, green: 131.0  / 255.0, blue: 241.0 / 255.0, alpha: 1.0)
    let colorNotSelected = UIColor(red:  231.0 / 255.0, green: 231.0 / 255.0, blue: 231.0 / 255.0, alpha: 1.0)
    
    var alternateButton: Array<RadioButton>?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        //self.layer.borderWidth = 2.0
        self.layer.masksToBounds = false
    }
    
    func unselectAlternateButtons() {
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        } else {
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton() {
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.backgroundColor = colorSelected.cgColor
                //self.layer.borderColor = colorSelected.cgColor
            } else {
                self.layer.backgroundColor = colorNotSelected.cgColor
            }
        }
    }
}

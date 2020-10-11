//
//  TitleView.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 27.09.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class TitleView: UIView {
    
    // MARK: - Properties
    
    private var characterDelay = 0.5
    private var translataionDuration = 0.5 * 8
    private var trailingConstraint = NSLayoutConstraint()
    
    @IBOutlet var titleLabel: UILabel!
    
    // MARK: - Configurate Function
    
    func configurate(withMultiplier multiplier: Double) {
        characterDelay *= multiplier
        translataionDuration *= multiplier
        
        setFontSize()
        
        guard let superview = superview else {
            return
        }
        
        trailingConstraint = self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -134)
        trailingConstraint.isActive = true
    }
    
    // MARK: - SetFontSize Function
    
    private func setFontSize() {
        titleLabel.isHidden = true
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.0
        titleLabel.text = "CarTouch"
        let newSize = titleLabel.getApproximateAdjustedFontSizeWithLabel()
        titleLabel.font = .systemFont(ofSize: newSize, weight: .bold)
        titleLabel.text = ""
        titleLabel.isHidden = false
    }
    
    // MARK: - Translate Animation
    
    private func translateNameAnimation() {
        guard let superview = superview else {
            return
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: translataionDuration, delay: 0.0, options: .curveEaseOut, animations: {
            self.trailingConstraint.constant = -32
            
            superview.layoutIfNeeded()
        }, completion: nil)
        
        titleLabel.animate(newText: "CarTouch", characterDelay: characterDelay)
    }
}

// MARK: - TitleAnimationProtocol

extension TitleView: TitleAnimationProtocol {
    
    func startAnimation() {
        translateNameAnimation()
    }
}

// MARK: - Animate label Text

extension UILabel {
    
    func animate(newText: String, characterDelay: TimeInterval) {
        DispatchQueue.main.async {
            self.text = ""
            
            var index = 0
            for character in newText {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
                    self.fadeTransition(characterDelay)
                    self.text?.append(character)
                }

                index += 1
            }
        }
    }
}

// MARK: - Animate Fade View

extension UIView {
    
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

// MARK: - Get Scaled Font After AutoScaling

extension UILabel {
    
    func getApproximateAdjustedFontSizeWithLabel() -> CGFloat {
        if self.adjustsFontSizeToFitWidth == true {
            var currentFont: UIFont = self.font
            let originalFontSize = currentFont.pointSize
            var currentSize: CGSize = (self.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: currentFont])

            while currentSize.width > self.frame.size.width && currentFont.pointSize > (originalFontSize * self.minimumScaleFactor) {
                currentFont = currentFont.withSize(currentFont.pointSize - 1)
                currentSize = (self.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: currentFont])
            }

            return currentFont.pointSize
        } else {
            return self.font.pointSize
        }
    }
}

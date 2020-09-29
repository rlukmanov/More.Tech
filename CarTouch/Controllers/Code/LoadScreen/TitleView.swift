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
    
    var translataionDuration = 2.0
    var characterDelay = 0.25
    private var screenWidthMultiplier = UIScreen.main.bounds.width / 414.0
    
    @IBOutlet var titleLabel: UILabel!
    
    // MARK: - Translate Animation
    
    private func translateNameAnimation() {
        let translateAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        translateAnimation.toValue = 120.0 * screenWidthMultiplier
        translateAnimation.duration = translataionDuration
        translateAnimation.fillMode = CAMediaTimingFillMode.forwards
        translateAnimation.isRemovedOnCompletion = false
        
        self.titleLabel.layer.add(translateAnimation, forKey: nil)
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
                    self.text?.append(character)
                    self.fadeTransition(characterDelay)
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
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

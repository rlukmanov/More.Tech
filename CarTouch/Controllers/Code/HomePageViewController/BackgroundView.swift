//
//  Background.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 28.09.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
    
    // MARK: - Properties
    
    @IBOutlet var titleLabel: UILabel!
    var durationAppear = 1.0
    
    // MARK: - Configurate Function
    
    func configurate() {
        titleLabel.alpha = 0
    }
    
    // MARK: - appearTitleAnimation
    
    func appearTitleAnimation() {
        titleLabel.fadeIn(withDuration: durationAppear)
    }
}

// MARK: - NameAnimationProtocol

extension BackgroundView: NameAnimationProtocol {
    
    func doAnimation(to valueAlpha: CGFloat, withDelay delay: TimeInterval, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.titleLabel.alpha = valueAlpha
        }, completion: nil)
    }
}

// MARK: - UILabel Fade Animation

extension UILabel {
    
    func fadeIn(withDuration duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }

    func fadeOut(withDuration duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
}

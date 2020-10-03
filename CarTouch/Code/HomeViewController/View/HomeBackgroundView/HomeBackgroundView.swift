//
//  Background.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 28.09.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class HomeBackgroundView: UIView {
    
    // MARK: - Properties
    
    var durationAppear = 1.0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gradientView: HomeGradientView!
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    // MARK: - Configurate
    
    func configurate() {
        titleLabel.alpha = 0
    }
    
    // MARK: - AppearTitleAnimation
    
    func appearTitleAnimation() {
        titleLabel.fadeIn(withDuration: durationAppear)
    }
}

// MARK: - NameAnimationProtocol & SetGradientViewTop

extension HomeBackgroundView: NameAnimationProtocol & SetGradientViewTop {
    
    func doAnimation(to valueAlpha: CGFloat, withDelay delay: TimeInterval, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.titleLabel.alpha = valueAlpha
        }, completion: nil)
    }
    
    func setGradientViewTopConstraint() {
        self.gradientView.topAnchor.constraint(equalTo: self.topAnchor, constant: 177).isActive = true
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

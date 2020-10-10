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
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var positionIcon: UIImageView!
    
    var positionIconCenterXAnchor = NSLayoutConstraint()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    // MARK: - Configurate

    func configurate() {
        titleLabel.alpha = 0.0
        historyLabel.alpha = 0.5
        
        positionIconCenterXAnchor = NSLayoutConstraint(item: positionIcon!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 0.5, constant: 0)

        positionIconCenterXAnchor.isActive = true
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

// MARK: - ChangePositionIcon

extension HomeBackgroundView: PositionIconProtocol {
    
    func changePositionIcon(offset: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            self.positionIconCenterXAnchor.constant = offset
            self.layoutIfNeeded()
        })
    }
}

// MARK: - ChangeCurrentTitle

extension HomeBackgroundView: ChangeCurrentTitle {
    
    func changeHistoryLabel() {
        searchLabel.fadeOut(toAlpha: 0.5, withDuration: 0.3)
        historyLabel.fadeIn(toAlpha: 1.0, withDuration: 0.3)
    }
    
    func changeSearchLabel() {
        historyLabel.fadeOut(toAlpha: 0.5, withDuration: 0.3)
        searchLabel.fadeIn(toAlpha: 1.0, withDuration: 0.3)
    }
}

// MARK: - UILabel Fade Animation

extension UILabel {
    
    func fadeIn(toAlpha alpha: CGFloat = 1.0, withDuration duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = alpha
        })
    }

    func fadeOut(toAlpha alpha: CGFloat = 0.0, withDuration duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = alpha
        })
    }
}

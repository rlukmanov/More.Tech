//
//  Background.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 28.09.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class BackgroundView: UIView {

    @IBOutlet var titleLabel: UILabel!
    var durationAppear = 1.0
    
    func appearTitleAnimation() {
        titleLabel.isHidden = false
        let animation = CATransition()
        animation.duration = durationAppear
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        animation.type = CATransitionType.fade
        titleLabel.layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

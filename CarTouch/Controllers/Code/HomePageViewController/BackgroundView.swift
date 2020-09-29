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
    
    func configurate() {
        titleLabel.alpha = 0
    }
    
    func appearTitleAnimation() {
        titleLabel.fadeIn(withDuration: durationAppear)
    }
}

// MARK: - UILabel fade animation

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

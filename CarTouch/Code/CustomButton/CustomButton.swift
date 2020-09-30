//
//  customButton.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 28.09.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    var color: UIColor = .black
    let touchDownAlpha: CGFloat = 0.3
    weak var timer: Timer?
    let timerStep: TimeInterval = 0.01
    let animateTime: TimeInterval = 0.4
    lazy var alphaStep: CGFloat = {
        return (1 - touchDownAlpha) / CGFloat(animateTime / timerStep)
    }()
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                touchDown()
            } else {
                cancelTracking(with: nil)
                touchUp()
            }
        }
    }

    func touchDown() {
        stopTimer()
        layer.backgroundColor = color.withAlphaComponent(touchDownAlpha).cgColor
    }
    
    func touchUp() {
        timer = Timer.scheduledTimer(timeInterval: timerStep,
                                     target: self,
                                     selector: #selector(animation),
                                     userInfo: nil,
                                     repeats: true)
    }

    @objc func animation() {
        guard let backgroundAlpha = layer.backgroundColor?.alpha else {
            stopTimer()
            return
        }

        let newAlpha = backgroundAlpha + alphaStep

        if newAlpha < 1 {
            layer.backgroundColor = color.withAlphaComponent(newAlpha).cgColor
        } else {
            layer.backgroundColor = color.cgColor
            stopTimer()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        if let backgroundColor = backgroundColor {
            color = backgroundColor
        }
        setup()
    }
    
    func setup() {
        backgroundColor = .clear
        layer.backgroundColor = color.cgColor
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    deinit {
        stopTimer()
    }
}

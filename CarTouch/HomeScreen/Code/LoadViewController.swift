//
//  LoadViewController.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 27.09.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class LoadViewController: UIViewController {
    
    var delayMultiplier = 0.3
    
    @IBOutlet weak var titleView: TitleView!
    @IBOutlet weak var iconView: IconView!
    
    @IBAction func start(_ sender: Any) {
        iconView.rotateCircleOne()
    }
    
    @IBAction func clear(_ sender: Any) {
        iconView.circleOneImageView.first!.layer.removeAllAnimations()
        iconView.circleTwoImageView.first!.layer.removeAllAnimations()
        iconView.circleThreeImageView.first!.layer.removeAllAnimations()
        iconView.circleFourImageView.first!.layer.removeAllAnimations()
        iconView.layer.removeAllAnimations()
        
        titleView.titleLabel.layer.removeAllAnimations()
        titleView.titleLabel.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconView.rotateDuration *= delayMultiplier
        iconView.scaleAntTranslationDuration *= delayMultiplier
        titleView.translataionDuration *= delayMultiplier
        titleView.characterDelay *= delayMultiplier
        
        iconView.delegate = titleView
    }

}

//
//  LoadViewController.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 27.09.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class LoadViewController: UIViewController {
    
    // MARK: - Properties
    
    var delayMultiplier = 0.5
    var characterMultiplier = 0.3
    var delayTransition = 0.5
    
    @IBOutlet weak var titleView: TitleView!
    @IBOutlet weak var iconView: IconView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconView.rotateDuration *= delayMultiplier
        iconView.scaleAntTranslationDuration *= delayMultiplier
        titleView.translataionDuration *= delayMultiplier
        titleView.characterDelay *= characterMultiplier
        
        iconView.delegate = titleView
        iconView.delegateHome = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            self.iconView.doRotation()
        })
    }
}

// MARK: ToHomeProtocol

extension LoadViewController: ToHomeProtocol {
    
    func toHomeScreen() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyboard.instantiateViewController(identifier: "HomePageVC") as! HomePageViewController
        
        let transition = CATransition()
        transition.duration = delayTransition
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(newViewController, animated: false)
        })
    }
}

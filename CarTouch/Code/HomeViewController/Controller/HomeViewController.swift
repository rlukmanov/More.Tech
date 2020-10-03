//
//  HomeViewController.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 03.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var backgroundView: HomeBackgroundView!
    @IBOutlet weak var mainView: MainView!
    @IBOutlet weak var scrollView: HomeScrollView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.delegate = backgroundView
        mainView.configurate()
        backgroundView.configurate()
        scrollView.delegateChangeTitle = backgroundView
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700), execute: {
            self.mainView.openView()
            self.backgroundView.appearTitleAnimation()
        })
    }
}

//
//  HomePageViewController.swift
//  HomePageCT
//
//  Created by Ruslan Lukmanov on 27.09.2020.
//

import UIKit

class HomePageViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var backgroundView: BackgroundView!
    @IBOutlet weak var mainView: MainView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.delegate = backgroundView
        backgroundView.configurate()
        mainView.configurate()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700), execute: {
            self.mainView.openView()
            self.backgroundView.appearTitleAnimation()
        })
    }
}

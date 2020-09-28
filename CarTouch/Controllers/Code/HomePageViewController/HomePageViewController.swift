//
//  HomePageViewController.swift
//  HomePageCT
//
//  Created by Ruslan Lukmanov on 27.09.2020.
//

import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: BackgroundView!
    @IBOutlet weak var mainView: MainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.configurate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            self.mainView.popupViewTapped()
            self.backgroundView.appearTitleAnimation()
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

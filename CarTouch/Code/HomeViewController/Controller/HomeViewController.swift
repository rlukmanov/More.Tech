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
    @IBOutlet weak var searchView: SearchView!
    
    let durationAppear = 1.0
    var leadingAnchor = NSLayoutConstraint()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var galleryCollectionView = GalleryCollectionView()
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delete LoadViewController
        self.navigationController?.viewControllers.remove(at: 0)
        
        mainView.delegate = backgroundView
        mainView.delegateCollectionView = galleryCollectionView
        mainView.configurate()
        backgroundView.configurate()
        scrollView.delegateChangeView = backgroundView
        
        galleryCollectionView.delegateToPrivateCab = self
        searchView.delegateToGalleryLoad = self
        
        //self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        view.addSubview(galleryCollectionView)
        
        galleryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 105).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalToConstant: 94).isActive = true
        leadingAnchor = galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width)
        leadingAnchor.isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700), execute: {
            self.mainView.openView()
            self.backgroundView.appearTitleAnimation()
            self.appearCollectionViewAnimation()
        })
    }
    
    // MARK: - AppearCollectionViewAnimation
    
    func appearCollectionViewAnimation() {
        
        UIView.animate(withDuration: self.durationAppear, delay: 0.0, options: .curveEaseOut, animations: {
            self.leadingAnchor.constant = 16
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: - ToPrivateCabProtocol

extension HomeViewController: ToPrivateCabProtocol {
    
    func toPrivateCab() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PersonalCabViewController") as! PersonalCabViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// MARK:- ToGalleryLoadProtocol

extension HomeViewController: ToGalleryLoadProtocol {
    
    func toGalleryLoad() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GalleryLoadViewController") as! GalleryLoadViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

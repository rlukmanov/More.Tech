//
//  SearchView.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 03.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

@IBDesignable class SearchView: UIView {
    
    // MARK: - Properties
    
    var view: UIView!
    var nibName: String = "SearchView"
    var delegateToGalleryLoad: ToGalleryLoadProtocol?
    
    var delegateCamera: ToCameraProtocol?
    
    // MARK: - Actions
    
    @IBAction func searchCameraAction(_ sender: Any) {
        delegateCamera?.toCamera()
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - LoadFromNib
    
    func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    // MARK: - Setup
    
    func setup() {
        view = loadFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .none
        
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        addSubview(view)
    }
    
    // MARK: - Actions
    
    @IBAction func toGalleryLoad(_ sender: Any) {
        delegateToGalleryLoad?.toGalleryLoad()
    }
}

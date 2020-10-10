//
//  GalleryCollectionView.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 10.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class GalleryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    var delegateToPrivateCab: ToPrivateCabProtocol?
    
    let toPersonalCabButton: UIButton = {
        let toPersonalCabButton = UIButton()
        toPersonalCabButton.backgroundColor = .none
        toPersonalCabButton.translatesAutoresizingMaskIntoConstraints = false
        return toPersonalCabButton
    }()
    
    let cells = GalleryCellModel.cellsNumber
    let maxOffsetScrollView: CGFloat = 144 // 260 - 144 // popupOffset - topOffset
    
    // MARK: - Init
    
    init() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = .none
        delegate = self
        dataSource = self
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = 10
        //contentInset = UIEdgeInsets(top: , left: , bottom: , right: )
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc
    func toPrivateCab() {
        delegateToPrivateCab?.toPrivateCab()
    }
    
    // MARK: - CollectionView(sizeForItemAt)
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 134, height: 94)
    }
}

// MARK: - UICollectionViewDataSource

extension GalleryCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell
        
        guard let index = indexPath.last else {
            return cell
        }
        
        cell.titleCellLabel.text = GalleryCellModel.titles[index]
        cell.titleButtonCellLabel.text = GalleryCellModel.subtitles[index]
        cell.iconImageView.image = GalleryCellModel.iconCell[index]
        cell.iconImageView.widthAnchor.constraint(equalToConstant: GalleryCellModel.sizes[index].0).isActive = true
        cell.iconImageView.heightAnchor.constraint(equalToConstant: GalleryCellModel.sizes[index].1).isActive = true
        
        if index == 0 {
            cell.addSubview(toPersonalCabButton)
            toPersonalCabButton.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
            toPersonalCabButton.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive =    true
            toPersonalCabButton.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
            toPersonalCabButton.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive =  true
            toPersonalCabButton.addTarget(self, action: #selector(toPrivateCab), for:   .touchUpInside)
        }
            
        return cell
    }
}

// MARK: - HideCollectionViewProtocol

extension GalleryCollectionView: HideCollectionViewProtocol {
    
    func animateHideCollectionView(withDuration duration: TimeInterval, offset: CGFloat) {
        guard let superview = superview else {
            return
        }
        
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1 - offset / self.maxOffsetScrollView
        })
    
        superview.layoutIfNeeded()
    }
    
    func disableCollectionView() {
        self.isScrollEnabled = false
    }
    
    func enableCollectionView() {
        self.isScrollEnabled = true
    }
}

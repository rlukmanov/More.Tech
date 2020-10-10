//
//  GalleryCollectionViewCell.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 10.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseId = "GalleryCollectionViewCell"
    
    let circleImageView: UIImageView = {
        let circleImageView = UIImageView()
        circleImageView.image = UIImage(named: "CircleIcon")
        circleImageView.translatesAutoresizingMaskIntoConstraints = false
        return circleImageView
    }()
    
    let titleCellLabel: UILabel = {
        let titleCellLabel = UILabel()
        titleCellLabel.numberOfLines = 0
        titleCellLabel.textColor = .black
        titleCellLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleCellLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleCellLabel
    }()
    
    let titleButtonCellLabel: UILabel = {
        let titleButtonCellLabel = UILabel()
        titleButtonCellLabel.textColor = UIColor(red: 58.0 / 255.0, green: 131.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0)
        titleButtonCellLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleButtonCellLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleButtonCellLabel
    }()
    
    let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        return iconImageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(circleImageView)
        addSubview(titleCellLabel)
        addSubview(titleButtonCellLabel)
        addSubview(iconImageView)
        
        self.backgroundColor = .white
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 8
        self.clipsToBounds = false
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        circleImageView.heightAnchor.constraint(equalToConstant: 39).isActive = true
        circleImageView.widthAnchor.constraint(equalToConstant: 39).isActive = true
        circleImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        circleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        
        titleCellLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true
        titleCellLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        
        titleButtonCellLabel.leadingAnchor.constraint(equalTo: titleCellLabel.leadingAnchor).isActive = true
        titleButtonCellLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11).isActive = true
        
        iconImageView.centerXAnchor.constraint(equalTo: circleImageView.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: circleImageView.centerYAnchor).isActive = true
    }
}

//
//  HideCollectionViewProtocol.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 10.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import Foundation
import UIKit

protocol HideCollectionViewProtocol {
    
    func animateHideCollectionView(withDuration duration: TimeInterval, offset: CGFloat)
    
    func disableCollectionView()
    
    func enableCollectionView()
}

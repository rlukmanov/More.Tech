//
//  HomeScrollView.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 03.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class HomeScrollView: UIScrollView {
    
    // MARK: - Property
    
    var delegateChangeView: (ChangeCurrentTitle & PositionIconProtocol)?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.delegate = self
    }
}

// MARK: - UIScrollViewDelegate

extension HomeScrollView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let offsetY = scrollView.contentOffset.y
        
        if offsetY != 0 {
            scrollView.contentOffset.y = 0
        }
        
        if offsetX == 0 {
            delegateChangeView?.changeSearchLabel()
        } else if offsetX == UIScreen.main.bounds.width {
            delegateChangeView?.changeHistoryLabel()
        }
        
        if offsetX >= 0, offsetX <= UIScreen.main.bounds.width {
            delegateChangeView?.changePositionIcon(offset: offsetX / 2)
        }
    }
}

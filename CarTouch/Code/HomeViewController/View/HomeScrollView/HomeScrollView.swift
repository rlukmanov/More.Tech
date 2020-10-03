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
    
    var delegateChangeTitle: ChangeCurrentTitle?
    
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
            delegateChangeTitle?.changeSearchLabel()
        } else if offsetX == UIScreen.main.bounds.width {
            delegateChangeTitle?.changeHistoryLabel()
        }
    }
}

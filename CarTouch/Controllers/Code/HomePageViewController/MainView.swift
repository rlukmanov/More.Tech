//
//  MainView.swift
//  HomePageCT
//
//  Created by Ruslan Lukmanov on 27.09.2020.
//

import UIKit

private enum State {
    case closed
    case open
}
 
extension State {
    var opposite: State {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}

class MainView: UIView {
    
    private var topConstraint = NSLayoutConstraint()
    private var currentState: State = .closed
    
    func configurate() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        guard let superview = superview else {
            return
        }
        
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        topConstraint = self.topAnchor.constraint(equalTo: superview.topAnchor, constant: UIScreen.main.bounds.height)
        topConstraint.isActive = true
    }
    
    func popupViewTapped() {
        guard let superview = superview else {
            return
        }
        let state = currentState.opposite
        
        let transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.topConstraint.constant = 287
                self.layer.cornerRadius = 20
            case .closed:
                self.topConstraint.constant = UIScreen.main.bounds.height
                self.layer.cornerRadius = 0
            }
            
            superview.layoutIfNeeded()
        })
        
        transitionAnimator.addCompletion { position in
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            @unknown default:
                return
            }
            switch self.currentState {
            case .open:
                self.topConstraint.constant = 287
                self.layer.cornerRadius = 20
            case .closed:
                self.topConstraint.constant = UIScreen.main.bounds.height
                self.layer.cornerRadius = 0
            }
        }
        
        transitionAnimator.startAnimation()
    }
}

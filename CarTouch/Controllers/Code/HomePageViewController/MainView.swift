//
//  MainView.swift
//  HomePageCT
//
//  Created by Ruslan Lukmanov on 27.09.2020.
//

import UIKit

// MARK: - State & Direction Enum

private enum Direction {
    case toMiddle
    case toUp
}

private enum State {
    case top
    case middle
}

class MainView: UIView {
    
    // MARK: - Properties
    
    private let popupOffset: CGFloat = 287
    private let popupOffsetMax: CGFloat = 357
    private var topConstraint = NSLayoutConstraint()
    
    // MARK: - Configurate Function
    
    func configurate() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.addGestureRecognizer(panRecognizer)
        
        guard let superview = superview else {
            return
        }
        
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        topConstraint = self.topAnchor.constraint(equalTo: superview.topAnchor, constant: UIScreen.main.bounds.height)
        topConstraint.isActive = true
    }
    
    // MARK: - OpenView Function
    
    func openView() {
        guard let superview = superview else {
            return
        }

        let transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            self.topConstraint.constant = self.popupOffset
            self.layer.cornerRadius = 20
            superview.layoutIfNeeded()
        })

        transitionAnimator.startAnimation()
    }
    
    // MARK: - Animation Panned
    
    private var offsetViewY: CGFloat = 0
    private var shouldReturn = false
    private var currentDirection: Direction = .toMiddle
    private var currentPosition: State = .middle
    
    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(popupViewPanned(recognizer:)))
        return recognizer
    }()

    private func animateTransitionIfNeeded(to state: Direction, duration: TimeInterval) {
        guard let superview = superview else {
            return
        }

        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            switch state {
            case .toUp:
                self.topConstraint.constant = 0
            case .toMiddle:
                self.topConstraint.constant = self.popupOffset
            }
            superview.layoutIfNeeded()
        })
        transitionAnimator.addCompletion({ _ in
            self.isUserInteractionEnabled = true
        })
        
        transitionAnimator.startAnimation()
    }
    
    private func animateStep(toValue currentConstraint: CGFloat) {
        let transitionAnimator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1, animations: {
            self.topConstraint.constant = currentConstraint
            self.superview!.layoutIfNeeded()
        })
        
        transitionAnimator.startAnimation()
    }
    
    @objc
    private func popupViewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            offsetViewY = topConstraint.constant - popupOffset
            if shouldReturn {
                switch currentPosition {
                case .top:
                    offsetViewY = -popupOffset
                case .middle:
                    offsetViewY = 0
                }
                animateTransitionIfNeeded(to: self.currentDirection, duration: 1.0)
                return
            }
        default:
            break
        }

        let offsetY = 2 * recognizer.translation(in: self).y
        let currentConstraint = popupOffset + offsetY + offsetViewY

        switch currentPosition {
        case .middle:
            currentDirection = .toMiddle
            shouldReturn = true

            if currentConstraint <= popupOffsetMax {
                if currentConstraint <= 0.7 * popupOffset {
                    shouldReturn = false
                    self.isUserInteractionEnabled = false
                    currentPosition = .top
                    offsetViewY = -popupOffset
                    animateTransitionIfNeeded(to: .toUp, duration: 1.0)
                } else {
                    animateStep(toValue: currentConstraint)
                }
            }
        case .top:
            currentDirection = .toUp
            shouldReturn = true

            if currentConstraint >= 0 {
                if currentConstraint >= 0.3 * popupOffset {
                    shouldReturn = false
                    self.isUserInteractionEnabled = false
                    currentPosition = .middle
                    offsetViewY = 0
                    animateTransitionIfNeeded(to: .toMiddle, duration: 1.0)
                } else {
                    animateStep(toValue: currentConstraint)
                }
            }
        }
    }
}

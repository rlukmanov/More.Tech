//
//  MainView.swift
//  CarTouch
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
    private let topOffset: CGFloat = 144
    private let upOffsetMultiplier = CGFloat(0.7)
    private let middleOffsetMultiplier = CGFloat(0.3)
    private let velocityEdge = CGFloat(500)
    private var velocityIs = false
    private var topConstraint = NSLayoutConstraint()
    
    var delegate: SetGradientViewTop?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    // MARK: - Configurate Function
    
    func configurate() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.addGestureRecognizer(panRecognizer)
        
        guard let superview = superview else {
            return
        }
        
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
        
        transitionAnimator.addCompletion({_ in 
            self.delegate?.setGradientViewTopConstraint()
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
    
    // MARK: - AnimateTransitionIfNeeded Function
    
    private func animateTransitionIfNeeded(to state: Direction, duration: TimeInterval) {
        guard let superview = superview else {
            return
        }
        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio:1, animations: {
            switch state {
            case .toUp:
                self.topConstraint.constant = self.topOffset
                //self.delegate?.doAnimation(to: 0.0, withDelay: 0.0, withDuration: 0.7)
            case .toMiddle:
                self.topConstraint.constant = self.popupOffset
                //self.delegate?.doAnimation(to: 1.0, withDelay: 0.0, withDuration: 0.7)
            }
            superview.layoutIfNeeded()
        })
        transitionAnimator.addCompletion({ _ in
            self.isUserInteractionEnabled = true
        })
        
        transitionAnimator.startAnimation()
    }
    
    // MARK: - AnimateStep Function
    
    private func animateStep(toValue currentConstraint: CGFloat) {
        let transitionAnimator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1, animations: {
            //var progressAnimation = currentConstraint / self.popupOffset
            //progressAnimation = progressAnimation > 1 ? 1 : progressAnimation
            
            self.topConstraint.constant = currentConstraint
            //self.delegate?.doAnimation(to: progressAnimation, withDelay: 0.0, withDuration: 0.1)
            self.superview!.layoutIfNeeded()
        })
        
        transitionAnimator.startAnimation()
    }
    
    // MARK: - PopupViewPanned Function
    
    @objc
    private func popupViewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            offsetViewY = topConstraint.constant - popupOffset
            if shouldReturn {
                switch currentPosition {
                case .top:
                    offsetViewY = -popupOffset + topOffset
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
                if currentConstraint <= topOffset + upOffsetMultiplier * (popupOffset - topOffset) {
                    shouldReturn = false
                    self.isUserInteractionEnabled = false
                    currentPosition = .top
                    offsetViewY = -popupOffset + topOffset
                    animateTransitionIfNeeded(to: .toUp, duration: 1.0)
                } else {
                    animateStep(toValue: currentConstraint)
                }
            }
        case .top:
            currentDirection = .toUp
            shouldReturn = true
            if currentConstraint >= topOffset {
                if currentConstraint >= topOffset + middleOffsetMultiplier * (popupOffset - topOffset) {
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

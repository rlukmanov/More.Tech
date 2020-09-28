//
//  GradientVIew.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 23.09.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit
@IBDesignable

class GradientView: UIView {
    
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map{ $0.cgColor }
        
        // let startGradient = Double(145.0 / self.frame.height)
        // let endGradient = Double(270.0 / self.frame.height)
        layer.locations = [0.0, 1.0]
    }
}
//
//  NameAnimationProtocol.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 29.09.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import Foundation
import UIKit

protocol NameAnimationProtocol {
    
    func doAnimation(to valueAlpha: CGFloat, withDelay delay: TimeInterval, withDuration duration: TimeInterval)
}

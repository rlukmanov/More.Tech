//
//  GalleryCellModel.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 10.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import Foundation
import UIKit

class GalleryCellModel {
    
    static let cellsNumber = ["One", "Two", "Three"]
    static let titles = ["Личный\nкабинет", "Мои\nзаявки", "Супер\nвыгода"]
    static let subtitles = ["Изменить", "Проверить", "Посмотреть"]
    static let iconCell = [UIImage(named: "Room"), UIImage(named: "Autocredit"), UIImage(named: "Subtract")]
    static let sizes = [(CGFloat(17.0), CGFloat(19.0)), (CGFloat(20.0), CGFloat(16.61)), (CGFloat(17.0), CGFloat(19.0))] // width, height constraints for icons
}


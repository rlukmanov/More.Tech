//
//  CarListModel.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 10.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import Foundation

class OfferModel: Codable {
    var hasBestMatch: Bool?
    var best: [CarListModel]?
    var result: [CarListModel]?
}

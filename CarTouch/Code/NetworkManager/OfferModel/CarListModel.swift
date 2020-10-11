//
//  CarListModel.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 11.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import Foundation

class CarListModel: Codable {
    var brand: BrandModel?
    var photo: String?
    var title: String?
    var minPrice: Int?
    var count: Int?
    var bodies: [BodyModel]?
    var transportType: String?
}

//
//  DetailInfoViewController.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 11.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class DetailInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    var data = CarListModel()
    var imageCar = UIImage()
    
    @IBOutlet weak var manufacterLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var typeBodyLabel: UILabel!
    @IBOutlet weak var typeCarLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var doorsLabel: UILabel!
    
    // MARK: - Actions
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        modelLabel.text = data.title
        manufacterLabel.text = data.brand?.title
        carImageView.image = imageCar
        priceLabel.text = getStringPrice(price: String(data.minPrice ?? 0))
        countryLabel.text = data.brand?.country?.title
        amountLabel.text = String(data.count ?? 0)
        typeCarLabel.text = data.transportType
        typeBodyLabel.text = data.bodies?.first?.title
        doorsLabel.text = String(data.bodies?.first?.doors ?? 0)
    }
    
    // MARK: - getStringPrice
    
    private func getStringPrice(price: String) -> String {
        var resultPrice = "от "
        var tempString = ""
        
        var i = 1
        for character in price.reversed() {
            tempString.append(character)
            
            if (i % 3) == 0 {
                tempString.append(" ")
            }
            i += 1
        }
        
        resultPrice += tempString.reversed()
        
        return resultPrice
    }
}

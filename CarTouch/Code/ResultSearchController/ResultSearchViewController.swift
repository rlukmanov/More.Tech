//
//  ResultSearchViewController.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 10.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class ResultSearchViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = OfferModel()
    
    // MARK: - Life Cycle Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150.0
    }
    
    //
    
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

// MARK: - UITableViewDataSource & UITableViewDelegate

extension ResultSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ResultTableViewCell {
           
            guard let index = indexPath.last else {
                return cell
            }
            
            cell.manufacterLabel.text = (data.result?[index].brand?.title) ?? ""
            cell.modelLabel.text = (data.result?[index].title) ?? ""
            cell.priceLabel.text = getStringPrice(price: String(data.result?[index].minPrice ?? 0))
            
            NetworkManager.shared.getImage(from: (data.result?[index].brand?.logo)!, completion: { (image) in

                guard let image = image else {
                    return
                }

                cell.manufacterImageView.image = image
            })
            
            NetworkManager.shared.getImage(from: (data.result?[index].photo)!, completion: { (image) in

                guard let image = image else {
                    return
                }

                cell.carImageView.image = image
            })
            
            return cell
        }
        
        return UITableViewCell()
    }
}

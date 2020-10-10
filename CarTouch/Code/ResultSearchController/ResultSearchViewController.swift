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
    
    let data = ["One", "Two", "Three", "Four", "Five"]
    
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
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension ResultSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ResultTableViewCell {
            //cell.titlelbl.text = data[indexPath.row]
            
            return cell
        }
        
        return UITableViewCell()
    }
}

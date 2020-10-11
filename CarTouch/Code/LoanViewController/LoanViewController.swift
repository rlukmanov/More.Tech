//
//  LoanViewController.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 11.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class LoanViewController: UIViewController {

    @IBAction func goToHomeAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomePageVCNew") as! HomeViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

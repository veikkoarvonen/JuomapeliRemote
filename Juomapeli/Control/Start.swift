//
//  ViewController.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 26.6.2024.
//

import UIKit

class Start: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "12", sender: self)
    }
    
}


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
        let t = Task(player1: "2", player2: "", drinkIndex: 0, color1: .red, color2: .red)
        print(t.normals.count)
        print(t.dates.count)
        print(t.tier1.count)
        print(t.tier2.count)
        print(t.tier3.count)
        print(t.tier4.count)
        print(t.tier5.count)
    }

    @IBAction func startPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "12", sender: self)
    }
    
}


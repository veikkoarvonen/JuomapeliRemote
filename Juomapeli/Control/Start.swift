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
        var g = WholeGame(numberOfTasks: 5, players: ["Veikko","Donia"], category: 2, tierSliderValue: 4.5, drinkSliderValue: 3)
        print(g.indexList)
        
        
    }
    
}


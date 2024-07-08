//
//  GameScreen.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 1.7.2024.
//

import UIKit

class GameSelectView: UIViewController, valueDelegate {
    
    var players: [String] = []
    var categoryForGame: Int = 0
    var tierValueForGame: Float = 3.0
    var drinkValueForGame: Float = 3.0
    
    
    @IBOutlet weak var tableView: UITableView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: C.gamemodeCell, bundle: nil), forCellReuseIdentifier: C.gamemodeNIb)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(named: C.blue)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "34" {
            let destinationVC = segue.destination as! GameView
            destinationVC.players = players
            destinationVC.gameCategory = categoryForGame
            destinationVC.tierValue = tierValueForGame
            destinationVC.drinkValue = drinkValueForGame
        }
    }
    
    func setValue(to: Float, forTier: Bool) {
        if forTier {
            tierValueForGame = to
        } else {
            drinkValueForGame = to
        }
    }
}

extension GameSelectView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.gamemodeNIb, for: indexPath) as! GameModeCell
        cell.delegate = self
        cell.header.text = Cells.headers[indexPath.row]
        cell.rules.text = Cells.paragraphs[indexPath.row]
        if indexPath.row != 2 {
            cell.lowerView.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat
        
        switch indexPath.row {
        case 0: height = 110
        case 1: height = 120
        case 2: height = 300
        default: height = 300
            
      
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoryForGame = indexPath.row
        var gategory: Int
        switch indexPath.row {
        case 0: gategory = 0; drinkValueForGame = 3
        case 1: gategory = 1; drinkValueForGame = 3
        case 2: gategory = 2
        default: gategory = 0
        }
        categoryForGame = gategory
        performSegue(withIdentifier: "34", sender: self)
    }
    
    
}

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
    var shouldPopProVC: Bool = false
    
    @IBOutlet weak var tableView: UITableView!
  
    override func viewDidAppear(_ animated: Bool) {
        if shouldPopProVC {
            performSegue(withIdentifier: "pro", sender: self)
            shouldPopProVC = false
        }
    }
    
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
    
    private func proLabel() -> UILabel {
        let label = UILabel()
        label.text = "Pro 🔒"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Marker Felt", size: 45)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        if let imageView = cell.customImageView {
            imageView.image = Cells.images[indexPath.row]
        } else {
            print("Image view is nil")
        }
        
        if indexPath.row != 0 {
            if !UserDefaults.standard.hasPurchasedProVersion() {
                cell.backView.alpha = 0.5
                cell.drinkSlider.isUserInteractionEnabled = false
                cell.actionSlider.isUserInteractionEnabled = false
                let label = proLabel()
                cell.backView.addSubview(label)
                NSLayoutConstraint.activate([
                    label.centerXAnchor.constraint(equalTo: cell.backView.centerXAnchor),
                    label.centerYAnchor.constraint(equalTo: cell.backView.centerYAnchor)
                ])
            } else {
                
            }
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
        var category: Int
        
        switch indexPath.row {
        case 0: category = 0; drinkValueForGame = 3
        case 1: category = 1; drinkValueForGame = 3
        case 2: category = 2
        default: category = 0
        }
        
        categoryForGame = category
        
        
        if indexPath.row != 0 {
            if UserDefaults.standard.hasPurchasedProVersion() {
                performSegue(withIdentifier: "34", sender: self)
                shouldPopProVC = true
            } else {
                performSegue(withIdentifier: "pro", sender: self)
            }
        } else {
            performSegue(withIdentifier: "34", sender: self)
            shouldPopProVC = true
        }
    }
    
    
}

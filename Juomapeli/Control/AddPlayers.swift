//
//  AddPlayers.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 26.6.2024.
//

import UIKit

class AddPlayers: UIViewController, CellDelegate {
    
    
    var players: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: C.playerTextCell, bundle: nil), forCellReuseIdentifier: C.playerTextNib)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        //showAddPlayerAlert()
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        if players.count < 2 {
            showErrorAlert()
        } else {
            performSegue(withIdentifier: "23", sender: self)
        }
    }
    
    @IBAction func addPlayerPressed(_ sender: UIBarButtonItem) {
        showAddPlayerAlert()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "23" {
            let destinationVC = segue.destination as! GameSelectView
            destinationVC.players = players
        }
    }
    
    func showAddPlayerAlert() {
            // Create the alert controller
            let alertController = UIAlertController(title: "Lisää pelaaja", message: nil, preferredStyle: .alert)
            
            // Add the text field to the alert
            alertController.addTextField { (textField) in
                textField.placeholder = "Pelaajan nimi"
                textField.autocapitalizationType = .words
            }
            
            // Add the "Cancel" action
            let cancelAction = UIAlertAction(title: "Peruuta", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            // Add the "Add Player" action
            let addAction = UIAlertAction(title: "Lisää", style: .default) { (_) in
                if let textField = alertController.textFields?.first, let playerName = textField.text {
                    // Handle the player name here
                    self.players.append(playerName)
                    self.tableView.reloadData()
                }
            }
            alertController.addAction(addAction)
            
            // Present the alert controller
            self.present(alertController, animated: true, completion: nil)
        }
    
    func showErrorAlert() {
            // Create the alert controller
            let alertController = UIAlertController(title: nil, message: "Lisää vähintään kaksi pelaajaa", preferredStyle: .alert)
            
            // Add the "Selvä" action
            let closeAction = UIAlertAction(title: "Selvä", style: .default, handler: nil)
            alertController.addAction(closeAction)
            
            // Present the alert controller
            self.present(alertController, animated: true, completion: nil)
        }
    
    func deleteCell(at index: Int) {
        
        guard index <= players.count else {
            return
        }
        players.remove(at: index)
        tableView.reloadData()
    }
    
    func addPlayer(name: String, row: Int) {
        
        if row >= players.count {
            players.append(name)
        } else {
            players[row] = name
        }
        tableView.reloadData()
        print(players)
    }
}

extension AddPlayers: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.playerTextNib, for: indexPath) as! TableViewTextCell
        cell.delegate = self
        cell.row = indexPath.row
        if indexPath.row < players.count {
            cell.textField.text = players[indexPath.row]
            cell.deleteButton.isHidden = false
        } else {
            cell.textField.text = ""
            cell.deleteButton.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    
}

//
//  GameScreen.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 26.6.2024.
//

import UIKit

class GameScreen: UIViewController {
    
    @IBOutlet weak var taskLabel: UILabel!
    var players: [String] = []
    var currentTask: Int = 0
    var shouldReturn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        newTask()
        shouldReturn = false
    }
    
    @objc func handleScreenTap() {
        if shouldReturn {
            navigationController?.popViewController(animated: true)
        } else {
            newTask()
            currentTask += 1
        }
        print(currentTask)
    }
    
    func newTask() {
        if currentTask > 29 {
            taskLabel.text = "Peli loppui!"
            currentTask = 0
            shouldReturn = true
        } else {
            guard players.count >= 2 else {
                return
            }
            let p1Index = Int.random(in: 0..<players.count)
            let p1 = players[p1Index]
            var remainingplayers = players
            remainingplayers.remove(at: p1Index)
            let p2 = remainingplayers.randomElement()!
            
            let task = GameBrain(player1: p1, player2: p2)
            taskLabel.text = task.newtask()
        }
    }
}

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
    var tasksToAppear: [Int] = []
    var shouldReturn: Bool = false
    var game: GameBrain = GameBrain(player1: "Moe", player2: "Jhees")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        shouldReturn = false
        tasksToAppear = tasksForGame()
        newTask()
        print(tasksToAppear)
    }
    
    @objc func handleScreenTap() {
        if shouldReturn {
            navigationController?.popViewController(animated: true)
            shouldReturn = false
        } else {
            newTask()
        }
    }
    
    func newTask() {
        guard players.count >= 2 else {
            return
        }
        
        if currentTask >= tasksToAppear.count {
            taskLabel.text = "Peli loppui!"
            shouldReturn = true
        } else {
            
            let pIndex = Int.random(in: 0..<players.count)
            let p1 = players[pIndex]
            
            var remainingPlayers = players
            remainingPlayers.remove(at: pIndex)
            let p2 = remainingPlayers.randomElement()
            
            game = GameBrain(player1: p1, player2: p2!)
            taskLabel.text = game.tasks[tasksToAppear[currentTask]]
            currentTask += 1
           
        }
    }
    
    func tasksForGame() -> [Int] {
        var taskIndexes: [Int] = []
        let totalTasks = game.tasks.count
        let requiredTasks = 10


        while taskIndexes.count < requiredTasks {
            let newIndex = Int.random(in: 0..<totalTasks)
            if !taskIndexes.contains(newIndex) {
                taskIndexes.append(newIndex)
            }
        }
        return taskIndexes
    }

    
    
}

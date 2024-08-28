//
//  GameScreen.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 26.6.2024.
//

import UIKit

class GameView: UIViewController {
    
    //From previous VC
    var players: [String] = []
    var gameCategory: Int = 0
    var tierValue: Float = 3.0
    var drinkValue: Float = 1.0
    
    //Game elements
    let numberOfTasks = 30
    var currentTask = 0
    var label = UILabel()
    var headLabel = UILabel()
    var shouldReturn = false
    
    //Generate based on info from previous VC
    var p1list: [Player] = []
    var p2list: [Player] = []
    var tiers: [Int] = []
    var tasksIndexes: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareGame()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func prepareGame() {
        var isDateCategory: Bool {
            if gameCategory == 1 {
                return true
            } else {
                return false
            }
        }
        let game = GameManager()
        let players = game.generatePlayerLists(players: players, numberOfTasks: numberOfTasks, isDateCategory: isDateCategory)
        p1list = players.p1
        p2list = players.p2
        tiers = game.generateTierList(sliderValue: tierValue, numberOfTasks: numberOfTasks)
        tasksIndexes = game.generateTaskIndexes(category: gameCategory, numberOfTasks: numberOfTasks, tiers: tiers)
        if gameCategory == 1 {
            view.backgroundColor = UIColor(red: 184/255.0, green: 108/255.0, blue: 165/255.0, alpha: 1.0)
        }
        newTask()
    }
    
    @objc func handleScreenTap() {
        if shouldReturn {
            navigationController?.popViewController(animated: true)
            shouldReturn = false
        } else {
            headLabel.removeFromSuperview()
            newTask()
        }
    }
    
    func newTask() {
        setLabel()
        if currentTask >= numberOfTasks {
            label.text = "Peli loppui!"
            shouldReturn = true
        } else {
            let p1 = p1list[currentTask].name
            let p2 = p2list[currentTask].name
            let c1 = p1list[currentTask].color
            let c2 = p2list[currentTask].color
            let tier = tiers[currentTask]
            let index = tasksIndexes[currentTask]
            let task = SingleTask(player1: p1, player2: p2, color1: c1, color2: c2, category: gameCategory, tier: tier, drinkValue: drinkValue, taskIndex: index)
            label.attributedText = task.getTask()
        }
        performShakingAnimation()
        currentTask += 1
    }
    
    func setLabel() {
        label.removeFromSuperview()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .black
        label.clipsToBounds = true
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 250)
        label.center.x = view.center.x
        label.center.y = view.frame.height / 2
        view.addSubview(label)
        performShakingAnimation()
    }
    
    func performShakingAnimation() {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        shakeAnimation.duration = 0.3
        shakeAnimation.values = [-9, 9, -6, 6, -3, 3, 0]
        label.layer.add(shakeAnimation, forKey: "shake")
    }
    
    func setHeadLabel() {
        headLabel.text = "Ohjeet"
        headLabel.numberOfLines = 0
        headLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headLabel.textAlignment = .center
        headLabel.textColor = .red
        headLabel.clipsToBounds = true
        headLabel.frame = CGRect(x: 0, y: 100, width: 200, height: 250)
        headLabel.center.x = view.center.x
        view.addSubview(headLabel)
    }
    
}

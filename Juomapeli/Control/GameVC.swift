//
//  GameScreen.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 26.6.2024.
//

import UIKit

class GameView: UIViewController {
    
    var players: [String] = []
    var gameCategory: Int = 0
    var tierValue: Float = 3.0
    var drinkValue: Float = 1.0
    
    var game = WholeGame(numberOfTasks: 30, players: ["P2","P1"], category: 0, tierSliderValue: 1, drinkSliderValue: 1)
    var tasks: [NSAttributedString] = []
    
    var currentTask = 0
    var label = UILabel()
    var headLabel = UILabel()
    var shouldReturn = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if gameCategory == 1 {
            view.backgroundColor = UIColor(red: 184/255.0, green: 108/255.0, blue: 165/255.0, alpha: 1.0)

        }
        
        game = WholeGame(numberOfTasks: 30, players: players, category: gameCategory, tierSliderValue: tierValue, drinkSliderValue: drinkValue)
        tasks = game.tasks
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
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
        
        if gameCategory == 1 && currentTask == 0 {
            setHeadLabel()
        }
        
        if currentTask >= tasks.count {
            label.text = "Peli loppui!"
            shouldReturn = true
        } else {
            label.attributedText = tasks[currentTask]
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

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
    
    var game = Game(players: [], gameCategory: 0, drinkIndex: 1, tierIndex: 1, numberOfTasks: 30)
    var colors = Colors.colors
    var tasks: [NSAttributedString] = []
    
    var currentTask = 0
    var label = UILabel()
    var shouldReturn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game(players: players, gameCategory: gameCategory, drinkIndex: drinkValue, tierIndex: tierValue, numberOfTasks: 30)
        tasks = game.getTasks()
        colors.shuffle()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        newTask()
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
        setLabel()
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
        label.center = view.center
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
    
}

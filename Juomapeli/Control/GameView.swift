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
    var headLabel = UILabel()
    
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
            if gameCategory == 1 && currentTask == 0 {
                setHeadLabel()
                let dateInstructions: String = "Kysy kortissa lukeva kysymys vastapelaajalta. Vuorosi jälkeen anna puhelin vastapelaajalle, jolloin hän kysyy sinulta seuraavan kysymyksen. Jesse kysyy ensiksi"
                label.text = dateInstructions
                label.frame = CGRect(x: 0, y: 0, width: 200, height: 350)
                label.center = view.center
            } else {
                label.attributedText = tasks[currentTask]
            }
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

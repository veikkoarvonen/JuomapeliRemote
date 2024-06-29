//
//  GameScreen.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 26.6.2024.
//

import UIKit

class GameScreen: UIViewController {
    
    var label = UILabel()
    var players: [String] = []
    var colors = Colors.colors
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
        colors.shuffle()
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
        guard players.count >= 2 else {
            return
        }
        
        if currentTask >= tasksToAppear.count {
            label.text = "Peli loppui!"
            shouldReturn = true
        } else {
            
            let pIndex = Int.random(in: 0..<players.count)
            let p1 = players[pIndex]
            
            var c1: UIColor
            var c2: UIColor
            
            if pIndex < colors.count {
                c1 = colors[pIndex]
            } else {
                c1 = .red
            }
            
            var remainingPlayers = players
            var remainingColors = colors
            remainingPlayers.remove(at: pIndex)
            remainingColors.remove(at: pIndex)
            let p2index = Int.random(in: 0..<remainingPlayers.count)
            let p2 = remainingPlayers[p2index]
            
            if p2index < remainingColors.count {
                c2 = remainingColors[p2index]
            } else {
                c2 = .orange
            }
            
        
            
            game = GameBrain(player1: p1, player2: p2)
            setLabel()
            let fullText = game.tasks[tasksToAppear[currentTask]]
            label.attributedText = attributedText(for: fullText, highlight1: p1, highlight2: p2, color1: c1, color2: c2)
            
            currentTask += 1
           
        }
    }
    
    func tasksForGame() -> [Int] {
        var taskIndexes: [Int] = []
        let totalTasks = game.tasks.count
        let requiredTasks = 30

        guard requiredTasks < totalTasks else {
           return [1,2,3]
        }

        while taskIndexes.count < requiredTasks {
            let newIndex = Int.random(in: 0..<totalTasks)
            if !taskIndexes.contains(newIndex) {
                taskIndexes.append(newIndex)
            }
        }
        return taskIndexes
    }

    func setLabel() {
        label.removeFromSuperview()
        //label.text = game.tasks[tasksToAppear[currentTask]]
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
    
    func attributedText(for fullText: String, highlight1: String, highlight2: String, color1: UIColor, color2: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: fullText)

        // Attributes for the highlighted texts
        let highlight1Attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color1,
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]
        let highlight2Attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color2,
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]

        // Apply attributes to highlight1
        let highlight1Range = (fullText as NSString).range(of: highlight1)
        if highlight1Range.location != NSNotFound {
            attributedString.addAttributes(highlight1Attributes, range: highlight1Range)
        }

        // Apply attributes to highlight2
        let highlight2Range = (fullText as NSString).range(of: highlight2)
        if highlight2Range.location != NSNotFound {
            attributedString.addAttributes(highlight2Attributes, range: highlight2Range)
        }
        
        return attributedString
    }
    
}

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
    var game = Game(players: [], gameCategory: 0, drinkIndex: 1, tierIndex: 1, numberOfTasks: 5)
    var tasks: [NSAttributedString] = []
    
    var currentTask = 0
    var label = UILabel()
    var shouldReturn = false
    var colors = Colors.colors
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game(players: players, gameCategory: gameCategory, drinkIndex: drinkValue, tierIndex: tierValue, numberOfTasks: 5)
        print(game.getTasks())
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
            let fullText = tasks[currentTask]
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

/*
var label = UILabel()
var players: [String] = []
var gameCategory: Int = 0
var tierValue: Float = 3.0
var drinkValue: Float = 1.0
var gameLength: Int = 30
var colors = Colors.colors
var currentTask: Int = 0
var tasksToAppear: [Int] = []
var shouldReturn: Bool = false
var game: ProGame = ProGame(gameGategory: 0, player1: "", player2: "", multiplier: 0, tierValue: 0)

override func viewDidLoad() {
    super.viewDidLoad()
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
    self.view.addGestureRecognizer(tapGestureRecognizer)
    shouldReturn = false
    tasksToAppear = tasksForGame()
    colors.shuffle()
    newTask()
    
    print(players)
    print(gameCategory)
    print(tierValue)
    print(drinkValue)
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
        
    
        
        game = ProGame(gameGategory: gameCategory, player1: p1, player2: p2, multiplier: drinkValue, tierValue: tierValue)
        setLabel()
        let fullText = game.normals[tasksToAppear[currentTask]]
        label.attributedText = attributedText(for: fullText, highlight1: p1, highlight2: p2, color1: c1, color2: c2)
        
        currentTask += 1
       
    }
}

func tasksForGame() -> [Int] {
    var taskIndexes: [Int] = []
    let totalTasks = game.normals.count
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
*/


//
//  GameScreen.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 26.6.2024.
//

import UIKit

class GameView: UIViewController {
    
//MARK: - Variables & constants
    
    var tapGesture: UITapGestureRecognizer?
    
    //Game parameters from previous VC
    var players: [String] = []
    var gameCategory: Int = 0
    var tierValue: Float = 3.0
    var drinkValue: Float = 1.0
    
    //Game elements
    let numberOfTasks = 30
    var currentTask = 0
    var taskLabel = UILabel()
    var shouldReturn = false
    
    //word explanation
    var points: Int = 0
    var pointLabel = UILabel()
    var timeLabel = UILabel()
    var words: [String] = []
    let gameTime: Int = 60
    var countdownTime: Int = 0
    var timer: Timer?
    var rButton = UIImageView()
    var lButton = UIImageView()
    
    //Generate based on info from previous VC
    var p1list: [Player] = []
    var p2list: [Player] = []
    var tiers: [Int] = []
    var tasksIndexes: [Int] = []
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var timebar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGameParameters()
        prepareGame()
        runIndexSafetyCheck()
        printGameParameters()
    }
    
    @objc func handleScreenTap() {
        
        guard !shouldReturn else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        if gameCategory == 3 {
            addButtons()
            addPointLabel()
            taskLabel.text = words[currentTask]
            currentTask += 1
            setTimer()
            tapGesture?.isEnabled = false
            timebar.isHidden = false
        } else {
            newTask()
        }
    }
    
//MARK: - Word explanation
    
    private func displayWordGameInstructions() {
        taskLabel.text = WordGame.startMessage
    }
    
    @objc private func handleLeftButtonTap() {
        newWord(didScorePoint: false)
    }

    @objc private func handleRightButtonTap() {
        newWord(didScorePoint: true)
    }
    
    private func addButtons() {
        // Create the left button
        let leftButton = UIImageView()
        leftButton.image = UIImage(named: "wrong")
        view.addSubview(leftButton)
        leftButton.frame = CGRect(x: 100, y: 100, width: 70, height: 70)
        leftButton.center.y = view.frame.height * (3 / 4) - 50
        leftButton.center.x = view.frame.width * (1 / 3)
        leftButton.isUserInteractionEnabled = true
        lButton = leftButton

        // Add tap gesture recognizer to the left button
        let leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLeftButtonTap))
        leftButton.addGestureRecognizer(leftTapGesture)

        // Create the right button
        let rightButton = UIImageView()
        rightButton.image = UIImage(named: "right")
        view.addSubview(rightButton)
        rightButton.frame = CGRect(x: 200, y: 100, width: 70, height: 70)
        rightButton.center.y = view.frame.height * (3 / 4) - 50
        rightButton.center.x = view.frame.width * (2 / 3)
        rightButton.isUserInteractionEnabled = true
        rButton = rightButton

        // Add tap gesture recognizer to the right button
        let rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleRightButtonTap))
        rightButton.addGestureRecognizer(rightTapGesture)
    }

    
    private func newWord(didScorePoint: Bool) {
        guard words.count > currentTask else { return }
        if didScorePoint {
            points += 1
            pointLabel.text = "Pisteet: \(points)"
        }
        taskLabel.text = words[currentTask]
        currentTask += 1
        performShakingAnimation()
    }
    
    private func addPointLabel() {
        pointLabel.text = "Pisteet: \(points)"
        pointLabel.textAlignment = .center
        pointLabel.textColor = .white
        pointLabel.font = UIFont(name: C.wordGameFont, size: 30)
        view.addSubview(pointLabel)
        //pointLabel.backgroundColor = .black
        pointLabel.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: 30)
    }
    
    private func setTimer() {
        countdownTime = gameTime
        timerFired()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    @objc func timerFired() {
        if countdownTime <= 0 {
            finishGame()
        } else {
            let progress = Float(countdownTime - 1) / Float(gameTime)
            UIView.animate(withDuration: 1.0, animations: {
                self.timebar.setProgress(progress, animated: true)
            })
            
            
            countdownTime -= 1
        }
    }
    
    private func finishGame() {
        timer?.invalidate()
        pointLabel.center.x = view.center.x
        pointLabel.center.y = view.center.y
        taskLabel.isHidden = true
        lButton.isHidden = true
        rButton.isHidden = true
        backImageView.isHidden = true
        timebar.isHidden = true
        performTypingAnimation()
        shouldReturn = true
        tapGesture?.isEnabled = true
    }
    
    private func performTypingAnimation() {
        pointLabel.text = ""
        let text = "Pisteet: \(points)"
        var charIndex = 0.0
        for letter in text {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in self.pointLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
//MARK: - New task
    
    private func newTask() {
        
        if shouldReturn {
            navigationController?.popViewController(animated: true)
        } else if currentTask >= numberOfTasks {
            endGame()
        } else {
            print("current task index: \(currentTask)")
            let p1 = p1list[currentTask].name
            let p2 = p2list[currentTask].name
            let c1 = p1list[currentTask].color
            let c2 = p2list[currentTask].color
            let category = gameCategory
            let tier = tiers[currentTask]
            let dValue = drinkValue
            let tIndex = tasksIndexes[currentTask]
            
            let task = SingleTask(player1: p1, player2: p2, color1: c1, color2: c2, category: category, tier: tier, drinkValue: dValue, taskIndex: tIndex)
            taskLabel.attributedText = task.getTask()
            performShakingAnimation()
            currentTask += 1
        }
    }
    
//MARK: - Task label
    
    private func initializeTaskLabel() {
        taskLabel.numberOfLines = 0
        taskLabel.font = UIFont.systemFont(ofSize: 20)
        taskLabel.textAlignment = .center
        taskLabel.textColor = .black
        taskLabel.clipsToBounds = true
        taskLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 250)
        taskLabel.center.x = view.center.x
        taskLabel.center.y = view.frame.height / 2
        view.addSubview(taskLabel)
    }
    
    private func performShakingAnimation() {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        shakeAnimation.duration = 0.3
        shakeAnimation.values = [-9, 9, -6, 6, -3, 3, 0]
        taskLabel.layer.add(shakeAnimation, forKey: "shake")
    }
    
    private func endGame() {
        taskLabel.text = "Peli loppui!"
        performShakingAnimation()
        shouldReturn = true
    }
    
//MARK: - Prepare game and parameters
    
    private func setGameParameters() {
        var isDateCategory: Bool = false
        if gameCategory == 1 {
            isDateCategory = true
        }
        
        let game = GameManager()
        let playerLists = game.generatePlayerLists(players: players, numberOfTasks: numberOfTasks, isDateCategory: isDateCategory)
        p1list = playerLists.p1
        p2list = playerLists.p2
        tiers = game.generateTierList(sliderValue: tierValue, numberOfTasks: numberOfTasks)
        tasksIndexes = game.generateTaskIndexes(category: gameCategory, numberOfTasks: numberOfTasks, tiers: tiers)
        words = WordGame.words
        words.shuffle()
    }
    
    private func prepareGame() {
        timebar.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        tapGesture = tapGestureRecognizer
        self.view.addGestureRecognizer(tapGestureRecognizer)
        initializeTaskLabel()
        
        if gameCategory == 1 {
            view.backgroundColor = UIColor(red: 184/255.0, green: 108/255.0, blue: 165/255.0, alpha: 1.0)
        }
        
        if gameCategory != 3 {
            newTask()
        }
        
        if gameCategory == 3 {
            displayWordGameInstructions()
            view.backgroundColor = .blue
        }
        
    }
    
//MARK: - Index safety check
    
    private func runIndexSafetyCheck() {
        
        let warningMessage = "Warning: one or more game parameters have invalid count!"
        
        guard p1list.count == 30 else {
            print(warningMessage)
            return
            
        }
        
        guard p2list.count == 30 else {
            print(warningMessage)
            return
            
        }
        
        guard tiers.count == 30 else {
            print(warningMessage)
            return
        }
        
        guard tasksIndexes.count == 30 else {
            print(warningMessage)
            return
        }
        
        print("Index safety check successful!")
        
    }
    
    private func printGameParameters() {
        print("Player 1 list: \(p1list)")
        print("Player 2 list: \(p2list)")
        print("Tiers for tasks: \(tiers)")
        print("Task indexes: \(tasksIndexes)")
    }
    
}

/*
    
//MARK: - Variables & constants
    
    //Game parameters from previous VC
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
  
//MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareGame()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
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
        if isDateCategory {
            view.backgroundColor = UIColor(red: 184/255.0, green: 108/255.0, blue: 165/255.0, alpha: 1.0)
        }
        newTask()
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
  
//MARK: - UI elements & functionality
    
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

*/

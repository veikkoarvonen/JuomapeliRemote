//
//  WholeGame.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 23.7.2024.
//

import UIKit

struct WholeGame {
    
    //Peliparametrit
    var numberOfTasks: Int
    var players: [String]
    var category: Int
    var tierSliderValue: Float
    var drinkSliderValue: Float
    
    //Pelaajat ja värit
    var player1list: [String] = []
    var player2list: [String] = []
    var color1list: [UIColor] = []
    var color2list: [UIColor] = []
    
    //Tier ja indeksi
    var tierList: [Int] = []
    var indexList: [Int] = []
    
    //Tehtävät
    var tasks: [NSAttributedString] = []
    
    
    init(numberOfTasks: Int, players: [String], category: Int, tierSliderValue: Float, drinkSliderValue: Float) {
        self.numberOfTasks = numberOfTasks
        self.players = players
        self.category = category
        self.tierSliderValue = tierSliderValue
        self.drinkSliderValue = drinkSliderValue
        playerLists()
        initializeTiers()
        initilizeIndexes()
        initializeTasks()
    }
  
//MARK: - Pelaajat ja värit
    
    mutating func playerLists() {
        
        if category == 1 {
            var x1 = 0
            var x2 = 1
            let limit = players.count
            var colors = Colors.colors
            colors.shuffle()
            
            for _ in 0..<numberOfTasks {
                if x1 >= limit {
                    x1 = 0
                }
                if x2 >= limit {
                    x2 = 0
                }
                player1list.append(players[x1])
                player2list.append(players[x2])
                color1list.append(colors[x1])
                color2list.append(colors[x2])
                x1 += 1
                x2 += 1
            }
            
        } else {
            var colors = Colors.colors
            colors.shuffle()
            for _ in 0..<numberOfTasks {
                var array = Array(0..<players.count)
                
                array.shuffle()
                
                let x1 = array[0]
                let x2 = array[1]
                player1list.append(players[x1])
                player2list.append(players[x2])
                color1list.append(colors[x1])
                color2list.append(colors[x2])
            }
        }
    }
    
//MARK: - Tehtävät pelille
    
    mutating func initializeTasks() {
        
        for i in 0..<numberOfTasks {
            
            let p1 = player1list[i]
            let p2 = player2list[i]
            let c1 = color1list[i]
            let c2 = color2list[i]
            let cat = category
            let tier = tierList[i]
            let drink = drinkSliderValue
            let index = indexList[i]
            
            let newTask = SingleTask(player1: p1, player2: p2, color1: c1, color2: c2, category: cat, tier: tier, drinkValue: drink, taskIndex: index)
            let tastString = newTask.getTask()
            
            tasks.append(tastString)
        }
        
        if category == 1 {
            let dateInstructions: String = "Kysy kortissa lukeva kysymys vastapelaajalta. Vuorosi jälkeen anna puhelin vastapelaajalle, jolloin hän kysyy sinulta seuraavan kysymyksen. \(players.last!) kysyy ensiksi"
            
            // Create a mutable attributed string
                let attributedString = NSMutableAttributedString(string: dateInstructions)
                
                // Find the range of the last player's name
            let lastPlayerRange = (dateInstructions as NSString).range(of: players.last!)
                
                // Define the attributes for the player's name
                let playerAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.boldSystemFont(ofSize: 24),
                    .foregroundColor: UIColor.red
                ]
                
                // Apply the attributes to the player's name
                attributedString.addAttributes(playerAttributes, range: lastPlayerRange)
               
            tasks.insert(attributedString, at: 0)
        }
    }
    
//MARK: - Indeksit
    
    mutating func initilizeIndexes() {
        
        let demoTask = SingleTask(player1: "", player2: "", color1: .red, color2: .red, category: 0, tier: 3, drinkValue: 3, taskIndex: 0)
        
        var arrays: [[Int]] = [
            Array(0..<demoTask.normals.count),
            Array(0..<demoTask.dates.count),
            Array(0..<demoTask.tier1.count),
            Array(0..<demoTask.tier2.count),
            Array(0..<demoTask.tier3.count),
            Array(0..<demoTask.tier4.count),
            Array(0..<demoTask.tier5.count)
        ]
        
        for i in 0..<arrays.count {
            arrays[i].shuffle()
        }
        
        for i in 0..<numberOfTasks {
            var targerArray: [Int]
            if category == 0 {
                targerArray = arrays[0]
            } else if category == 1 {
                targerArray = arrays[1]
            } else {
                
                guard tierList.count >= i else {
                    print("Tierlist doesn't contain \(i) items!")
                    break
                }
                
                switch tierList[i] {
                case 1: targerArray = arrays[2]
                case 2: targerArray = arrays[3]
                case 3: targerArray = arrays[4]
                case 4: targerArray = arrays[5]
                case 5: targerArray = arrays[6]
                default: targerArray = arrays[1]
                }
            }
            indexList.append(targerArray[i])
        }
        
    }
    
//MARK: - Tierit pelille
    
    mutating func initializeTiers() {
        
        for _ in 0..<numberOfTasks {
            let tier: Int = getTier(tierValue: tierSliderValue)
            tierList.append(tier)
        }
        
    }


//MARK: - Tier todennäköisyys
    
    func getTier(tierValue: Float) -> Int {
        let tier1 = probability(for: 1)
        let tier2 = probability(for: 2)
        let tier3 = probability(for: 3)
        let tier4 = probability(for: 4)
        let tier5 = probability(for: 5)
        
        //should pick a tier from 1 to 5 randomly using probablisities
        let totalProb = tier1 + tier2 + tier3 + tier4 + tier5
        let randomPicker = Float.random(in: 0..<totalProb)
        var tier: Int
        
        let limit1 = tier1
        let limit2 = limit1 + tier2
        let limit3 = limit2 + tier3
        let limit4 = limit3 + tier4
        let limit5 = limit4 + tier5
        
        if randomPicker < limit1 {
            tier = 1
        } else if randomPicker < limit2 {
            tier = 2
        } else if randomPicker < limit3 {
            tier = 3
        } else if randomPicker < limit4 {
            tier = 4
        } else {
            tier = 5
        }
        
        return tier
    }
    
    func probability(for tier: Int) -> Float {
        var x1: Float
        var x2: Float
        let minValue = tierSliderValue - 5 / 6
        let maxValue = tierSliderValue + 5 / 6
        
        switch tier {
            case 1:
                x1 = 0
                x2 = 1.5
            case 2:
                x1 = 1.5
                x2 = 2.5
            case 3:
                x1 = 2.5
                x2 = 3.5
            case 4:
                x1 = 3.5
                x2 = 4.5
            case 5:
                x1 = 4.5
                x2 = 6
            default:
                x1 = 0
                x2 = 6
            }
        
        var probability: Float
        
        if minValue > x2 || maxValue < x1 {
            probability = 0
        } else if minValue < x1 && maxValue > x2 {
            probability = 0.6
        } else if minValue > x1 && minValue < x2 {
            probability = (x2 - minValue) * 3 / 5
        } else if maxValue > x1 && maxValue < x2 {
            probability = (maxValue - x1) * 3 / 5
        } else {
            probability = 1.0
        }
        
        return probability
        
    }
    
}

//self.player1 = player1
//self.player2 = player2
//self.color1 = color1
//self.color2 = color2
//self.category = category
//self.tier = tier
//self.drinkValue = drinkValue
//self.taskIndex = taskIndex

//
//  WholeGame.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 23.7.2024.
//

import UIKit

struct Player {
    var name: String
    var color: UIColor
}

struct GameManager {
 
//MARK: - Playerlists & colors
    
    func generatePlayerLists(players: [String], numberOfTasks: Int, isDateCategory: Bool) -> (p1: [Player], p2: [Player]) {
        
        //Initialize & randomize colors
        var colors = Colors.colors
        colors.shuffle()
        
        //Generate indexes for players 1 & 2
        var p1indexes = generateIndexes(from: 0, playerAmount: players.count, numberOfTasks: numberOfTasks)
        var p2indexes: [Int] = []
        
        //Shuffle players if not date category & generate player 2 list
        if isDateCategory {
            p2indexes = generateIndexes(from: 1, playerAmount: players.count, numberOfTasks: numberOfTasks)
        } else {
            p1indexes.shuffle()
            for i in 0..<numberOfTasks {
                var p2array = Array(0..<players.count)
                p2array.remove(at: p1indexes[i])
                p2indexes.append(p2array.randomElement()!)
            }
        }
        
        //Create player1 structs
        var p1array: [Player] {
            var p: [Player] = []
            for i in 0..<p1indexes.count {
                let index = p1indexes[i]
                let name = players[index]
                var color: UIColor {
                    if index < colors.count {
                        return colors[index]
                    } else {
                        return .purple
                    }
                }
                let newPlayer = Player(name: name, color: color)
                p.append(newPlayer)
            }
            return p
        }
        
        //Create player2 structs
        var p2array: [Player] {
            var p: [Player] = []
            for i in 0..<p2indexes.count {
                let index = p2indexes[i]
                let name = players[index]
                var color: UIColor {
                    if index < colors.count {
                        return colors[index]
                    } else {
                        return .purple
                    }
                }
                let newPlayer = Player(name: name, color: color)
                p.append(newPlayer)
            }
            return p
        }
        
        
        //Return arrays
        return (p1: p1array, p2: p2array)
    }
 
//MARK: Tiers for game
    
    func generateTierList(sliderValue: Float, numberOfTasks: Int) -> [Int] {
        let min = sliderValue - 6 / 10
        let max = sliderValue + 6 / 10
        
        var tiers: [Int] = []
        
        //determine tiers based on sliders position
        for _ in 0..<numberOfTasks {
            
            let tierIndex = Float.random(in: min...max)
            
            if tierIndex > 4.5 {
                tiers.append(5)
            } else if tierIndex > 3.5 {
                tiers.append(4)
            } else if tierIndex > 2.5 {
                tiers.append(3)
            } else if tierIndex > 1.5 {
                tiers.append(2)
            } else {
                tiers.append(1)
            }
        }
        
        return tiers
        
    }

//MARK: - Task indexes for game
    
    func generateTaskIndexes(category: Int, numberOfTasks: Int, tiers: [Int]) -> [Int] {
        let task = SingleTask(player1: "", player2: "", color1: .red, color2: .red, category: 0, tier: 0, drinkValue: 0, taskIndex: 0)
        var indexArrays: [[Int]] = [
            Array(0..<task.normals.count),
            Array(0..<task.dates.count),
            Array(0..<task.tier1.count),
            Array(0..<task.tier2.count),
            Array(0..<task.tier3.count),
            Array(0..<task.tier4.count),
            Array(0..<task.tier5.count)
        ]
        
        for i in 0..<indexArrays.count {
            indexArrays[i].shuffle()
        }
        
        var indexes: [Int] = []
        
        if category == 0 {
            indexes = indexArrays[0]
        } else if category == 1 {
            indexes = indexArrays[1]
        } else {
            for i in 0..<numberOfTasks {
                let tier = tiers[i]
                let targetArray = indexArrays[tier + 1]
                indexes.append(targetArray[i])
            }
        }
        
        return indexes
        
    }
    
    func generateIndexes(from startingIndex: Int, playerAmount: Int, numberOfTasks: Int) -> [Int] {
        
        var indexes: [Int] = []
        var currentIndex = startingIndex
        for _ in 0..<numberOfTasks {
            if currentIndex < playerAmount {
                indexes.append(currentIndex)
            } else {
                currentIndex = 0
                indexes.append(currentIndex)
            }
            currentIndex += 1
        }
        return indexes
    }
    
}

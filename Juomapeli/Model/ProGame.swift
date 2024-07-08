//
//  ProGame.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 1.7.2024.
//

import Foundation

struct ProGame {
    
    let gameGategory: Int
    let player1: String
    let player2: String
    let multiplier: Float
    let tierValue: Float
    
    var normals: [String] = []
    var dates: [String] = []
    var tier1: [String] = []
    var tier2: [String] = []
    var tier3: [String] = []
    var tier4: [String] = []
    var tier5: [String] = []
    
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
        let minValue = tierValue - 5 / 6
        let maxValue = tierValue + 5 / 6
        
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
    
  
    func getNumber(input: Int) -> Int {
        let kerroin = (1 / 16) * (multiplier * multiplier) + (7 / 16)
        let amount = kerroin * Float(input)
        let finalNumber = amount.rounded()
        return Int(finalNumber)
        
    }
    
    
    
  
    
    init(gameGategory: Int, player1: String, player2: String, multiplier: Float, tierValue: Float) {
        self.gameGategory = gameGategory
        self.player1 = player1
        self.player2 = player2
        self.multiplier = multiplier
        self.tierValue = tierValue
        
        self.normals = [
            
            "Jesse on somali"
        ]
        
        self.dates = [
            
        ]
        
        self.tier1 = [
        
        ]
        
        self.tier2 = [

        ]
        
        self.tier3 = [

        ]
        
        self.tier4 = [

        ]
        
        self.tier5 = [

        ]
    }
    
}

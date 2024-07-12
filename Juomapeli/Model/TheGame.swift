//
//  TheGame.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 12.7.2024.
//

import UIKit


struct TTask {
    var player1: String
    var player2: String
    var color1: UIColor
    var color2: UIColor
    var drinkIndex: Float
    
    var allTasks: [OneTask] = []
    
    func getNumber(input: Int) -> Int {
        let kerroin = (0.09735) * (drinkIndex * drinkIndex) + (0.15625)
        let amount = kerroin * Float(input)
        let finalNumber = amount.rounded()
        return Int(finalNumber)
        
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










struct OneTask {
    var task: String
    var categories: [Int]
    
    init(task: String, categories: [Int]) {
        self.task = task
        self.categories = categories
    }
}

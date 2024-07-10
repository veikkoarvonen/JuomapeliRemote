//
//  GameModeCell.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 1.7.2024.
//

import UIKit

class GameModeCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lowerView: UIView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var rules: UILabel!
    @IBOutlet weak var actionSlider: UISlider!
    @IBOutlet weak var drinkSlider: UISlider!
    @IBOutlet weak var customImageView: UIImageView!
    
    var delegate: valueDelegate?
    
    @IBAction func actionSliderChanged(_ sender: UISlider) {
        delegate?.setValue(to: sender.value, forTier: true)
    }
    
    @IBAction func drinkSliderChanged(_ sender: UISlider) {
        delegate?.setValue(to: sender.value, forTier: false)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  TableViewCell.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 26.6.2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    var delegate: CellDelegate?
    var index: Int?
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        guard let indexNumber = index else {
            return
        }
        delegate?.deleteCell(at: indexNumber)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

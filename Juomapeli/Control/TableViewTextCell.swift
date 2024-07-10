//
//  TableViewTextCell.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 10.7.2024.
//

import UIKit

class TableViewTextCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    @IBAction func deletePressed(_ sender: UIButton) {
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

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
        delegate?.deleteCell(at: row!)
    }
    
    var row: Int?
    var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 5
        textField.delegate = self
        
        
        setPlaceholder(text: " + Lisää pelaaja")
        
        backView.layer.masksToBounds = false
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 0.1
        backView.layer.shadowOffset = CGSize(width: 0, height: 2)
        backView.layer.shadowRadius = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setPlaceholder(text: String) {
        let placeholderText = text
        let placeholderColor = UIColor.white // Your desired color
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
    }
    
}

extension TableViewTextCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if text != "" {
                delegate?.addPlayer(name: text, row: row!)
            }
        }
        // Typically used to dismiss the keyboard
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setPlaceholder(text: "")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setPlaceholder(text: " + Lisää pelaaja")
        if let text = textField.text {
            if text != "" {
                delegate?.addPlayer(name: text, row: row!)
            }
        }
    }
}

//
//  ProView.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 25.7.2024.
//

import UIKit

class ProView: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @objc func label1Tapped() {
          print("Label 1 tapped")
          // Handle the tap event for label 1
      }
      
      @objc func label2Tapped() {
          print("Label 2 tapped")
          // Handle the tap event for label 2
      }
      
      @objc func label3Tapped() {
          print("Label 3 tapped")
          // Handle the tap event for label 3
      }
    
}

extension ProView {
    private func setUpUI() {
        label1.clipsToBounds = true
        label2.clipsToBounds = true
        label3.clipsToBounds = true
        label1.layer.cornerRadius = 10
        label2.layer.cornerRadius = 10
        label3.layer.cornerRadius = 10
        label1.text = "  0.99€ / vk 🚀"
        label2.text = "  2.99€ / kk 🌟"
        label3.text = "  9.99€ / v 💎"
        
        label1.isUserInteractionEnabled = true
        label2.isUserInteractionEnabled = true
        label3.isUserInteractionEnabled = true
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(label1Tapped))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(label2Tapped))
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(label3Tapped))
        
        label1.addGestureRecognizer(tapGesture1)
        label2.addGestureRecognizer(tapGesture2)
        label3.addGestureRecognizer(tapGesture3)
    }
}

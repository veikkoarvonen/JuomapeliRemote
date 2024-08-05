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
        discountLabel()
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
        
        let roundness: CGFloat = 20
        
        label1.clipsToBounds = true
        label2.clipsToBounds = true
        label3.clipsToBounds = true
        label1.layer.cornerRadius = roundness
        label2.layer.cornerRadius = roundness
        label3.layer.cornerRadius = roundness
        label3.text = "   0.99€ / viikko"
        label2.text = "   3.99€ / kuukausi"
        label1.text = "   9.99€ / vuosi"
        
        label1.isUserInteractionEnabled = true
        label2.isUserInteractionEnabled = true
        label3.isUserInteractionEnabled = true
        
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        label3.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(label1Tapped))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(label2Tapped))
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(label3Tapped))
        
        label1.addGestureRecognizer(tapGesture1)
        label2.addGestureRecognizer(tapGesture2)
        label3.addGestureRecognizer(tapGesture3)
        
        addShadow(to: label1)
        addShadow(to: label2)
        addShadow(to: label3)
    }
    
    private func discountLabel() {
        // Create the UIImageView
        let imageView = UIImageView()
        imageView.image = UIImage(named: "discount")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the UIImageView to the view
        view.addSubview(imageView)
        
        // Set constraints for the UIImageView
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            imageView.centerYAnchor.constraint(equalTo: label1.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),  // Adjust width as needed
            imageView.heightAnchor.constraint(equalToConstant: 200)  // Adjust height as needed
        ])
    }
    
    private func addShadow(to label: UILabel) {
        label.layer.shadowColor = UIColor.black.cgColor // Ensure the shadow color contrasts with the label's background
        label.layer.shadowOffset = CGSize(width: 2, height: 50) // Adjust to your preference
        label.layer.shadowOpacity = 0.7 // Ensure the opacity is high enough to see
        label.layer.shadowRadius = 10 // Adjust to your preference
    }
}

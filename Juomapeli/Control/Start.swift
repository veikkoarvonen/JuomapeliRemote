//
//  ViewController.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 26.6.2024.
//

import UIKit

class Start: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
        print(UserDefaults.standard.hasPurchasedProVersion())
        UserDefaults.standard.setProVersionPurchased(false)
        
    }

    @IBAction func startPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "12", sender: self)
        
        
    }
    
    private func setUpUI() {
        
        let ukot = UIImageView()
        ukot.image = UIImage(named: "ukot2")
        ukot.contentMode = .scaleAspectFill
        ukot.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ukot)
        
        
        let image = UIImageView()
        image.image = UIImage(named: "alkutausta")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        view.sendSubviewToBack(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ukot.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ukot.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ukot.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ukot.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
            if motion == .motionShake {
                print("Device was shaken")
                handleShakeGesture()
            }
        }
        
        private func handleShakeGesture() {
            // Create the alert controller
            let alertController = UIAlertController(title: "Plus tilin aktivointi", message: "Syötä salasana", preferredStyle: .alert)
            
            // Add a text field to the alert
            alertController.addTextField { textField in
                textField.placeholder = "1234"
                textField.isSecureTextEntry = true // Makes the text field secure for password entry
            }
            
            // Add a dismiss button to the alert
            let dismissAction = UIAlertAction(title: "Valmis", style: .default) { _ in
                // Handle the dismiss action if needed
                if let textField = alertController.textFields?.first {
                    if textField.text == "skebaa" {
                        self.updatePlusStatus()
                    } else {
                        self.presentAlert(title: "Skebaa ei buri", message: "")
                    }
                }
            }
            alertController.addAction(dismissAction)
            
            // Present the alert controller
            present(alertController, animated: true, completion: nil)
        }
        
        private func updatePlusStatus() {
            // Update the UserDefaults to indicate the pro version is purchased
            UserDefaults.standard.setProVersionPurchased(true)
            
            // Notify the user
            presentAlert(title: "Plus versio", message: "Plus versio aktivoitu!")
        }
    
    private func presentAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

}



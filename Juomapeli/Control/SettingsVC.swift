//
//  Settings.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 25.7.2024.
//

import UIKit
import StoreKit

class SettingsView: UIViewController, SKPaymentTransactionObserver {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let headers = Settings.headers
    let items = Settings.sections
    let ud = UD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        SKPaymentQueue.default().add(self)
    }
    
    func restorePlusPurchace() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .restored {
                ud.setPlusVersionStatus(purchased: true)
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
        
    }
}

extension SettingsView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: C.purple)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = headers[section]
        label.font = UIFont(name: "Marker Felt", size: 18)
        label.textColor = .white
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Settings.sections[section]
        let count = section.count
        return count
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let section = Settings.sections[indexPath.section]
            let text = section[indexPath.row]
            cell.textLabel?.text = text
            cell.textLabel?.numberOfLines = 0
            cell.accessoryType = .disclosureIndicator
            if indexPath.section == 1 && indexPath.row == 0 {
                cell.accessoryType = .none
            }
            
            if indexPath.section == 2 && indexPath.row == 0 && ud.hasPurchasedPlusVersion() {
                cell.textLabel?.text = "Peruuta Plus -tilaus"
            }
            
            return cell
        }
        
        // MARK: - UITableViewDelegate
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let urls = [
                    "https://veikkoarvonen.github.io/juomapelicup/",
                    "https://veikkoarvonen.github.io/juomapelicup/HTML/app-privacy-policy.html",
                    "https://veikkoarvonen.github.io/juomapelicup/HTML/app-terms-and-conditions.html",
                    "https://veikkoarvonen.github.io/juomapelicup/HTML/vastuullisuus.html"
                ]
            
            var urlIndex: Int?
            
            if indexPath.section == 0 {
                switch indexPath.row {
                case 0: urlIndex = 0
                case 1: urlIndex = 1
                case 2: urlIndex = 2
                default: urlIndex = nil
                }
            } else if indexPath.section == 1 && indexPath.row == 1 {
                urlIndex = 3
            } else {
                urlIndex = nil
            }
            
            if let index = urlIndex {
                if let url = URL(string: urls[index]), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
            }
            
            
            // Handle cell selection
            tableView.deselectRow(at: indexPath, animated: true)
        }
}

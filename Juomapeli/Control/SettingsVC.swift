//
//  Settings.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 25.7.2024.
//

import UIKit

class SettingsView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let headers = Settings.headers
    let items = Settings.sections
    let ud = UD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
            // Handle cell selection
            tableView.deselectRow(at: indexPath, animated: true)
        }
}

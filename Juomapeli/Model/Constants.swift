//
//  Constants.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 1.7.2024.
//

import UIKit

struct C {
    static let playerCell = "TableViewCell"
    static let playerNib = "tableViewCell"
    static let gamemodeCell = "GameModeCell"
    static let gamemodeNIb = "gameModeCell"
    static let playerTextCell = "TableViewTextCell"
    static let playerTextNib = "tableViewTextCell"
    
    static let purple = "brandPurple"
    static let blue = "brandBlue"
}

struct Cells {
    static let images: [UIImage] = [UIImage(named: "resized1")!,UIImage(named: "resized2")!,UIImage(named: "resized3")!]
    static let headers: [String] = ["Peruspeli", "Treffit", "Extreme"]
    static let paragraphs: [String] = [
        "Monipuolisia tehtäviä ja haasteita, jotka takaavat räväkän meiningin hyvän maun rajoissa... juuri ja juuri.",
        "Syvällisiä, hauskoja sekä mielenkiintoisia kysymyksiä ja tehtäviä, joiden avulla varmasti tutustut seuralaiseesi - myös pintaa syvemmältä.",
        "VAROITUS: Ei nynnyille! Alla olevista mittareista voit itse valita pelin intensiteetin ja rangaistushuikkien määrän. Huom: Tehtävät vaativat pahimmillaan äärimmäistä heittäytymistä, joten peli sopii ainoastaan kovimmille bilihileille!"
    ]
}

struct Colors {
    static let colors: [UIColor] = [
        UIColor(red: 0/255.0, green: 74/255.0, blue: 173/255.0, alpha: 1.0),   // #004AAD
        UIColor(red: 255/255.0, green: 0/255.0, blue: 207/255.0, alpha: 1.0),  // #FF00CF
        UIColor(red: 0/255.0, green: 35/255.0, blue: 255/255.0, alpha: 1.0),   // #0023FF
        UIColor(red: 166/255.0, green: 17/255.0, blue: 48/255.0, alpha: 1.0),  // #A61130
        UIColor(red: 39/255.0, green: 112/255.0, blue: 30/255.0, alpha: 1.0),  // #27701E
        UIColor(red: 255/255.0, green: 0/255.0, blue: 184/255.0, alpha: 1.0),  //#FF00B8
        UIColor.red,
        UIColor.orange
    ]
}


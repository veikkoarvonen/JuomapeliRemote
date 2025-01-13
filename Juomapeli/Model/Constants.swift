//
//  Constants.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 1.7.2024.
//

import UIKit
import StoreKit

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
    static let images: [UIImage] = [UIImage(named: "basicGame")!,UIImage(named: "treffit")!,UIImage(named: "extreme")!, UIImage(named: "selita")!]
    static let headers: [String] = ["Peruspeli", "Treffit", "Extreme", "Sanaselitys"]
    static let paragraphs: [String] = [
        "Monipuolisia tehtäviä ja haasteita, jotka takaavat räväkän meiningin pysyen kuitenkin hyvän maun rajoissa... juuri ja juuri.",
        "Syvällisiä, hauskoja ja mielenkiintoisia kysymyksiä ja tehtäviä, joiden avulla varmasti tutustut seuralaiseesi - myös pintaa syvemmältä.",
        "VAROITUS: Ei nynnyille! Alla olevista mittareista voit itse valita pelin intensiteetin ja rangaistushuikkien määrän.                                           HUOM: Tehtävät vaativat pahimmillaan äärimmäistä heittäytymistä, joten peli sopii ainoastaan kovimmille bilehileille!",
        "Sanaselitys! Sinulla on minuutti aikaa selittää pelikaverillesi niin monta sanaa, kuin kerkeät. Jokaisesta oikeasta vastauksesta saatte pisteen."
    ]
}

struct Settings {
    
    static let headers: [String] = ["Tietoa", "Vastuullisuus", "Plus-tilaus"]
    
    static let sections: [[String]] = [
        ["Juomapeli Cup kotisivut", "Tietosuojakäytäntö", "Käyttöehdot"],
        ["Muista pitää itsestäsi ja pelitovereistasi huolta. Kyseinen peli on tarkoitettu ainoastaan viihteelliseen käyttöön, eikä ketään tule pakottaa jatkamaan peliä, ellei halua. Mikäli pelin yhteydessä nautitaan päihteitä, tulee käyttäjien olla täysi-ikäisiä ja nauttia alkoholia vastuullisesti. Emme vastaa mistään vahingoista tai seuraamuksista, jotka voivat aiheutua vastuuttomasta pelaamisesta.","Lue lisää vastuullisuudesta"],
        ["Osta Juomapeli Plus", "Palauta ostot"]
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

struct UD {
    
    let purchasedProductIDs: String = "purchasedProductIDs"
    
    func addKey(key: String) {
        UserDefaults.standard.set(key, forKey: purchasedProductIDs)
    }
    
    func setPlusVersionStatus(purchased: Bool) {
        
    }
    
    func hasPurchasedPlusVersion() -> Bool {
        return false
    }
    
}







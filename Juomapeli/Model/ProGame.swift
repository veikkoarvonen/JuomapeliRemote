//
//  ProGame.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 1.7.2024.
//

import Foundation

struct ProGame {
    
    let gameGategory: Int
    let player1: String
    let player2: String
    let multiplier: Float
    let tierValue: Float
    
    var normals: [String] = []
    var dates: [String] = []
    var tier1: [String] = []
    var tier2: [String] = []
    var tier3: [String] = []
    var tier4: [String] = []
    var tier5: [String] = []
    
    func getTier(tierValue: Float) -> Int {
        let tier1 = probability(for: 1)
        let tier2 = probability(for: 2)
        let tier3 = probability(for: 3)
        let tier4 = probability(for: 4)
        let tier5 = probability(for: 5)
        
        //should pick a tier from 1 to 5 randomly using probablisities
        let totalProb = tier1 + tier2 + tier3 + tier4 + tier5
        let randomPicker = Float.random(in: 0..<totalProb)
        var tier: Int
        
        let limit1 = tier1
        let limit2 = limit1 + tier2
        let limit3 = limit2 + tier3
        let limit4 = limit3 + tier4
        let limit5 = limit4 + tier5
        
        if randomPicker < limit1 {
            tier = 1
        } else if randomPicker < limit2 {
            tier = 2
        } else if randomPicker < limit3 {
            tier = 3
        } else if randomPicker < limit4 {
            tier = 4
        } else {
            tier = 5
        }
        
        return tier
    }
    
    func probability(for tier: Int) -> Float {
        var x1: Float
        var x2: Float
        let minValue = tierValue - 5 / 6
        let maxValue = tierValue + 5 / 6
        
        switch tier {
            case 1:
                x1 = 0
                x2 = 1.5
            case 2:
                x1 = 1.5
                x2 = 2.5
            case 3:
                x1 = 2.5
                x2 = 3.5
            case 4:
                x1 = 3.5
                x2 = 4.5
            case 5:
                x1 = 4.5
                x2 = 6
            default:
                x1 = 0
                x2 = 6
            }
        
        var probability: Float
        
        if minValue > x2 || maxValue < x1 {
            probability = 0
        } else if minValue < x1 && maxValue > x2 {
            probability = 0.6
        } else if minValue > x1 && minValue < x2 {
            probability = (x2 - minValue) * 3 / 5
        } else if maxValue > x1 && maxValue < x2 {
            probability = (maxValue - x1) * 3 / 5
        } else {
            probability = 1.0
        }
        
        return probability
        
    }
    
  
    func getNumber(input: Int) -> Int {
        let kerroin = (1 / 16) * (multiplier * multiplier) + (7 / 16)
        let amount = kerroin * Float(input)
        let finalNumber = amount.rounded()
        return Int(finalNumber)
        
    }
    
    
    
  
    
    init(gameGategory: Int, player1: String, player2: String, multiplier: Float, tierValue: Float) {
        self.gameGategory = gameGategory
        self.player1 = player1
        self.player2 = player2
        self.multiplier = multiplier
        self.tierValue = tierValue
        
        self.normals = [
            "\(player1), totuus vai tehtävä?",
            "\(player1), suutele edessäsi olevaa pelaajaa tai ota \(getNumber(input: 4)) huikkaa",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "\(player1), ota 1 shotti",
            "\(player1), tee 10 punnerrusta tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), röyhtäise tai juo \(getNumber(input: 3)) huikkaa",
            "Kertokaa tarina sana kerrallaan, se joka jäätyy ekana juo \(getNumber(input: 3)) huikkaa",
            "\(player1), niin monta punnerrusta kuin sinä teet, \(player2) ottaa huikkia",
            "\(player1), freestyle räppää tästä illasta. Muut pelaajat ovat tuomaristo ja päättävät, selviätkö rangaistukselta (\(getNumber(input: 3)) huikkaa)",
            "\(player1), nuolaise pelaajan \(player2) jalkaa tai ota \(getNumber(input: 3)) huikkaa",
            "\(player1), laita seuraavat ruumiinosat viehättävyysjärjestykseen: kainalot, varpaat, korvat",
            "\(player1), Telepatiahaaste! Yrittäkää sanoa pelaajan \(player2) kanssa sama sana samaan aikaan. Jos epäonnistutte juotte molemmat \(getNumber(input: 2)) huikkaa. Kategoria: väri",
            "\(player1), ota \(getNumber(input: 3)) huikkaa tai poskiläimäisy pelaajalta \(player2)",
            "\(player1), sano 5 kertaa putkeen ”floridan broileri ja reilu litra maitoa” illan että kieli menee solmuun, tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), ota bodyshot pelaajalta \(player2)",
            "\(player1), demonstroi suosikki seksiasentosi pelaajan \(player2) kanssa",
            "\(player1), oudoin asia jota olet tehnyt seksin aikana?",
            "\(player1), haista pelaajan \(player2) kainaloa tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), onko sinulla fetissejä? Paljasta ne tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), soita exällesi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), esitä känniläistä 15 sekuntia tai juo \(getNumber(input: 2)) huikkaa",
            "\(player1), näytä viimeisin lähettämäsi viesti tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), imitoi muiden pelaajien valitsemaa julkkista tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), soita tutullesi ja sano että rakastat häntä",
            "\(player1), mikä on mielestäsi rumin kehonosa vastakkaisessa sukupuolessa?",
            "\(player1), ota huikka ilman käsiä",
            "\(player1), näytä viimeisin kuva puhelimesi ”Kätketyt”-albumista",
            "\(player1), kerro vitsi. Jos muut pelaajat eivät naura, juo \(getNumber(input: 2)) huikkaa",
            "\(player1), anna pelaajalle \(player2) sylitanssi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), anna pelaajan \(player2) laittaa sun someen jotain tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), juo raaka kananmuna tai ota \(getNumber(input: 3)) huikkaa",
            "\(player1), aina kun kiroilet, juo huikka loppupelin ajan",
            "\(player1), milloin viimeksi harrastit seksiä?",
            "\(player1), milloin viimeksi masturboit?",
            "\(player1), kuvaile viimeisintä katsomaasi aikuisviihdevideota",
            "\(player1), laula pelaajan \(player2) valitsemaa biisiä tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), näytä nänni tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), kerro salaisuus tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), oletko kiinnostunut kenestäkään",
            "\(player1), yritä saada pelaaja \(player2) nauramaan 30 sekunnin aikana. Jos epäonnistut, juo \(getNumber(input: 3)) huikkaa",
            "\(player1), ota paita pois loppupelin ajaksi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), ota housut pois loppupelin ajaksi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), twerkkaa 10 sekuntia tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), anna paras Mikki Hiiri -imitaatiosi",
            "\(player1), ota tuijotuskilpailu pelaajan \(player2) kanssa. Häviäjä juo \(getNumber(input: 3)) huikkaa",
            "\(player1), ota pelaaja \(player2) reppuselkään ja tee 3 kyykkyä, tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), vaihda vaatteita henkilön \(player2) kanssa tai juokaa molemmat \(getNumber(input: 5)) huikkaa",
            "\(player1), seuraavan 3 kierroksen ajan, saat puhua vain laulaen",
            "\(player1), seuraavan 3 kierroksen ajan, saat puhua vain suu kiinni. Jos epäonnistut, juo 3 huikkaa",
            "\(player1), tyynyjuttele tyynylle 30 sekunnin ajan tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), keksi jokaiselle pelaajalle uusi lempinimi",
            "\(player1), imitoi leijonaa 15 sekunnin ajan",
            "\(player1), juo lasi vettä yhdellä kulauksella",
            "\(player1), putkita mieto",
            "\(player1), näytä parhaimmat tanssiliikkeesi seuraavan 15 sekunnin ajan tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), näytä seksikkäin ilme minkä osaat tehdä",
            "\(player1), anna pelaajan \(player2) laittaa itsellesi huulipunaa loppupelin ajaksi",
            "\(player1), kerro nolo muisto",
            "\(player1), imitoi orgasmia 10 sekunnin ajan tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), ole loppupeli silmät sidottuna",
            "\(player1), freestyle räppää aiheesta: ”Olen rakastunut pelaajaan \(player2)”",
            "\(player1), puhu pelaajalle \(player2) kuin vauvalle",
            "\(player1), soita vanhemmillesi ja kerro olevasi raskaana, tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), lähetä tuhmin mahdollinen tekstiviesti pelaajalle \(player2) vain emojeita käyttäen",
            "Ottakaa ryhmäkuva",
            "Ottakaa ryhmäkuva mahdollisimman rumilla ilmeillä",
            "\(player1), anna pelaajan \(player2) laittaa viestiä puhelimellasi valitsemalleen henkilölle",
            "\(player1), nimeä 10 sekunnissa 5 maata jotka alkavat kirjaimella S tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), nimeä 10 disney-prinsessaa 15 sekunnissa tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), riisu pelaajan \(player2) sukat hampaillasi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), mene ulos ja ulvo suden lailla tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), anna pelaajan \(player2) stailata hiuksesi loppu pelin ajaksi, tai juon4 huikkaa",
            "\(player1), aina kun juot, voihki jokaisen hörpyn jälkeen loppupelin ajan",
            "\(player1), esitä apinaa 10 sekunnin ajan tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), haista pelaajan \(player2) kainaloa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), haista jokaisen pelaajan jalkoja ja kerro kenellä on pahin haju, tai juo \(getNumber(input: 6)) huikkaa",
            "\(player1), arvaa minkä väriset alushousut pelaajall \(player2) on. Jos arvaat oikein, hän juo \(getNumber(input: 3)) huikkaa. Jos väärin, juo itse \(getNumber(input: 3))",
            "\(player1), soita ilmakitaraa 15 sekunnin ajan eläytyen tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), esitä robottia seuraavan 3 kierroksen ajan tai juo \(getNumber(input: 6)) huikkaa",
            "\(player1), imitoi pelaajista valitsemaasi henkilöä niin pitkään, että joku arvaa ketä imitoit",
            "\(player1), tee 10 kyykkyä samalla kun \(player2) makaa selällään allasi",
            "\(player1), murise seksikkäästi tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), anna 30 sekunnin jalkahieronta pelaajalle \(player2) tai ota \(getNumber(input: 4)) huikkaa",
            "\(player1), yritä laittaa pelaajan \(player2) nyrkki omaan suuhusi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), yritä nuolaista kyynärpäätäsi. Jos epäonnistut, juo 2 huikkaa",
            "\(player1), kuori banaani varpaillasi tai ota \(getNumber(input: 4)) huikkaa",
            "\(player1), puhu kolmen kierroksen ajan ilman, että huulesi koskettavat. Jos epäonnistut, juo \(getNumber(input: 3)) huikkaa",
            "\(player1), imitoi jotain julkkista kunnes muut pelaajat arvaavat ketä esität. Jos epäonnistut, juo \(getNumber(input: 4)) huikkaa",
            "\(player1), mene kolmen kierroksen ajaksi nurkkaan istumaan itseksesi tai juo 5 huikkaa",
            "\(player1), anna paras Hessu Hopo -imitaatiosi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), riisu 2 valitsemaasi vaatekappaletta tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), yritä saada muut pelaajat nauramaan puhumatta. Jos epäonnistut, juo \(getNumber(input: 3)) huikkaa",
            "\(player1), jos puhelimesi ruutuaika on suurempi kuin pelaajalla \(player2), juo \(getNumber(input: 3)) huikkaa. Muussa tapauksessa \(player2) juo \(getNumber(input: 3)) huikkaa.",
            "\(player1), vastaa kaikkeen 'kyllä' seuraavan minuutin ajan tai juo 5 huikkaa",
            "\(player1), veikkaa, missä pisteessä jokainen pelaaja on seuraavan 5 vuoden aikana",
            "\(player1), saat puhua vain kuiskaten seuraavan 3 kierroksen ajan. Jos epäonnistut, juo \(getNumber(input: 3)) huikkaa",
            "\(player1), twerkkaa 15 sekunnin ajan tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), näytä orgasmi-ilmeesi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), syö banaani viettelevästi tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), soita ilmakitaraa 15 sekunnin ajan tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), et saa nauraa loppupelin ajan. Jos epäonnistut, juo 5 huikkaa",
            "\(player1), kuiskaa salaisuus pelaajalle \(player2). Jos hän ei reagoi mitenkään, juo 2 huikkaa",
            "\(player1), päätä, kuka pelaajista juo 3 huikkaa",
            "\(player1), ota \(getNumber(input: 4)) huikkaa",
            "\(player1), ota 2 huikkaa",
            "\(player1), ota \(getNumber(input: 3)) huikkaa",
            "\(player1), paras kehonosa vastakkaisella sukupuolella?",
            "\(player1), ota kivi-sakset-paperi -matsi pelaajan \(player2) kanssa. Häviäjä juo \(getNumber(input: 3)) huikkaa",
            "Kaikki pelaajat, joilla on siitin, juovat \(getNumber(input: 3)) huikkaa",
            "\(player1), jos olisit peruna, tulisitko mieluummin kuorituksi vai keitetyksi?",
            "\(player1), monenko ihmisen kanssa olet harrastanut seksiä? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), onko koolla väliä?",
            "\(player1), oletko omasta mielestäsi hyvä sängyssä? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), mikä on suurin fantasiasi? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), mikä on kiusallisin tilanne, johon olet joutunut? Vastaa tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), jos sinun pitäisi harrastaa roolileikkiä pelaajan \(player2) kanssa, miksi pukeutuisitte?",
            "\(player1), mikä on erikoisin paikka, jossa olet harrastanut seksiä? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "Jesse on somali"
        ]
        
        self.dates = [
            
        ]
        
        self.tier1 = [
        
        ]
        
        self.tier2 = [

        ]
        
        self.tier3 = [

        ]
        
        self.tier4 = [

        ]
        
        self.tier5 = [

        ]
    }
    
}

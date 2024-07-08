//
//  Game.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 8.7.2024.
//

import UIKit

struct Game {
    var players: [String]
    var gameCategory: Int
    var drinkIndex: Float
    var tierIndex: Float
    var numberOfTasks: Int
    var colors: [UIColor] = Colors.colors
    
    init(players: [String], gameCategory: Int, drinkIndex: Float, tierIndex: Float, numberOfTasks: Int) {
        self.players = players
        self.gameCategory = gameCategory
        self.drinkIndex = drinkIndex
        self.tierIndex = tierIndex
        self.numberOfTasks = numberOfTasks
        colors.shuffle()
    }
    
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
        let minValue = tierIndex - 5 / 6
        let maxValue = tierIndex + 5 / 6
        
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
    
    func getTiers() -> [Int] {
        
        var tiers: [Int] = []
        
        for _ in 0..<numberOfTasks {
            let tier: Int = getTier(tierValue: tierIndex)
            tiers.append(tier)
        }
        
        return tiers
    }
    
    func getIndexes() -> [Int] {
        var array = Array(0..<30)
        array.shuffle()
        return array
    }
    
    func getTasks() -> [NSAttributedString] {
        
        guard players.count >= 2 else {
            print("game should have at least 2 players")
            return []
        }
        
        var p1: String
        var p2: String
        var c1: UIColor
        var c2: UIColor
        
        var tasks: [NSAttributedString] = []
        
        let tiers = getTiers()
        var indexes = getIndexes()
        
        for i in 0..<numberOfTasks {
            
            var playersForTask = players
            var colorsForTask = colors
            let p1Index = Int.random(in: 0..<players.count)
            p1 = players[p1Index]
            c1 = colors[p1Index]
            playersForTask.remove(at: p1Index)
            colorsForTask.remove(at: p1Index)
            let p2Index = Int.random(in: 0..<playersForTask.count)
            p2 = playersForTask[p2Index]
            c2 = colorsForTask[p2Index]
            
            let index = indexes[i]
            
            let task = Task(player1: p1, player2: p2, drinkIndex: drinkIndex, color1: c1, color2: c2)
            let tier = tiers[i]
            let taskString = task.getTask(category: gameCategory, tier: tier, index: index)
            tasks.append(taskString)
        }
        
        return tasks
        
    }
    
}


struct Task {
    
    //pelaajat
    var player1: String
    var player2: String
    var color1: UIColor
    var color2: UIColor
    
    //Kysymykset
    var normals: [String] = []
    var dates: [String] = []
    var tier1: [String] = []
    var tier2: [String] = []
    var tier3: [String] = []
    var tier4: [String] = []
    var tier5: [String] = []
    
    //Huikkamäärä
    var drinkIndex: Float
    
    //Käyttöönotto
    init(player1: String, player2: String, drinkIndex: Float, color1: UIColor, color2: UIColor) {
        self.player1 = player1
        self.player2 = player2
        self.color1 = color1
        self.color2 = color2
        self.drinkIndex = drinkIndex
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
        ]
        
        self.dates = [
            "\(player1), kerro jokin red flag itsestäsi",
                "\(player1), kerro jokin red flag vastakkaisessa sukupuolessa",
                "\(player1), kerro jokin green flag vastakkaisessa sukupuolessa",
                "\(player1), tee jokin olettamus pelaajasta \(player2)",
                "Laittakaa huulenne vastakkain 3 sekunniksi, mutta älkää suudelko",
                "\(player1), kerro itsestäsi 2 totuutta ja yksi valhe. Jos \(player2) arvaa valheen, juo 3 huikkaa",
                "\(player1), kerro salaisuus",
                "\(player1), kuvaile itseäsi 3 sanalla",
                "\(player1), kuvaile pelaajaa \(player2) 3 sanalla",
                "\(player1), uskotko johonkin yliluonnolliseen?",
                "\(player1), mikä on suosikki elokuvasi?",
                "\(player1), mikä oli lapsuuden haaveammattisi?",
                "\(player1), ketä julkisuuden henkilöä ihailet?",
                "\(player1), kerro jokin nolo muisto",
                "\(player1), mikä on pahin pelkosi?",
                "\(player1), raha vai rakkaus?",
                "\(player1), mikä on mielestäsi paras piirre itsessäsi?",
                "\(player1), pidätkö itseäsi outona?",
                "\(player1), mikä on suosikki urheilulajisi?",
                "\(player1), mikä on suurin unelmasi?",
                "\(player1), milloin viimeksi olet lukenut kirjan?",
                "\(player1), uskallatko näyttää puhelimesi kuvagallerian pelaajalle \(player2)?",
                "\(player1), sano joku biisi jota inhoat",
                "\(player1), sulje silmäsi. Minkä väriset silmät pelaajalla \(player2) on? Jos arvaat väärin, juo 3 huikkaa",
                "\(player1), jos sinun olisi pakko tatuoida jotain otsaasi, mitä se olisi?",
                "\(player1), onko sinulla yhtäkään fobiaa?",
                "\(player1), onko sinulla fetissejä? Jos kyllä, uskallatko kertoa pelaajalle \(player2) niistä?",
                "\(player1), demonstroi asento jossa yleensä nuku",
                "\(player1), jos olisitte kävelyllä ja \(player2) yhtäkkiä liukastuisi, nauraisitko vai olisitko huolissasi?",
                "\(player1), miten reagoisit, jos \(player2) kosisi sinua nyt?",
                "\(player1), kuuluuko ananas pizzaan?",
                "\(player1), mikä on spontaanein asia, jonka olet tehnyt?",
                "\(player1), näytä jokin uniikki taito jonka osaat. Jos et osaa mitään, juo 3 huikkaa",
                "\(player1), mikä on/oli suosikki oppiaineesi koulussa?",
                "\(player1), mikä on/oli inhokki oppiaineesi koulussa?",
                "\(player1), kerro jokin mielipiteesi, josta valtaosa on eri mieltä",
                "\(player1), uskotko taikuuteen?",
                "\(player1), uskotko rakkauteen ensisilmäyksellä?",
                "\(player1), mikä oli ensivaikutelmasi pelaajasta \(player2)?",
            "\(player1), oletko ikinä ollut rakastunut?",
            "\(player1), ovatko ensitreffit yleensä hauskoja vai stressaavia mielestäsi?",
            "\(player1), mitä haet parisuhteelta?",
            "\(player1), kumpi maksaa ensitreffit?",
            "\(player1), mikä on parasta sinkkuna olemisessa?",
            "\(player1), mikä on parasta parisuhteessa olemisessa?",
            "\(player1), jos voisit, haluaisitko elää ikuisesti?",
            "\(player1), mikä on mielestäsi viehättävin piirre vastakkaisessa sukupuolessa?",
            "\(player1), miten flirttailet yleensä?",
            "\(player1), mikä epäseksuaalinen piirre on sellainen, jota itse pidät viehättävänä?",
            "\(player1), mitä haluaisit tehdä pelaajan \(player2) kanssa yhdessä?",
            "\(player1), hiero pelaajan \(player2) hartioita 30 sekuntia tai juo 4 huikkaa",
            "\(player1), mikä on paras iskureplasi?",
            "\(player1), jos olisit peruna, tulisitko mielummin kuorituksi vai keitetyksi?"
        ]
        
        self.tier1 = [
            "\(player1), nimeä viisi jediritaria Tähtiensota-elokuvista tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), jos olisit peruna, tulisitko mieluummin kuorituksi vai keitetyksi?",
            "\(player1), niin monta punnerrusta kuin sinä teet, \(player2) ottaa huikkia",
            "Kertokaa tarina sana kerrallaan, se joka jäätyy ekana juo \(getNumber(input: 3)) huikkaa",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "\(player1), ota 1 shotti",
            "\(player1), tee 10 punnerrusta tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), keksi jokaiselle pelaajalle uusi lempinimi",
            "\(player1), imitoi pelaajista valitsemaasi henkilöä niin pitkään, että joku arvaa ketä imitoit",
            "\(player1), kerro jokin paheesi",
            "\(player1), kuuluuko ananas pizzaan?, juo niin monta huikkaa kuin pelaajia on eri mieltä kanssasi",
            "\(player1), luettele suomalaisten aakkosten vokaalit takaperin. Jos epäonnistut, juo \(getNumber(input: 3)) huikkaa",
            "\(player1), mainitse jokin hyvä ominaisuus pelaajasta \(player2)",
            "\(player1), nimeä 4 James Bond -näyttelijää 10:ssä sekunnissa. Epäonnistumisesta \(getNumber(input: 3)) huikkaa",
            "\(player1), puhu niin monella kielellä jotain järkevää kuin osaat. Jokaista kieltä kohden muut juovat \(getNumber(input: 2)) huikkaa",
            "\(player1) päättää kategorian. Ensimmäinen joka ei osaa nimetä uutta asiaa, ottaa \(getNumber(input: 3)) huikkaa",
            "\(player1), nimeä 10 NATO-maata 10:ssä sekunnissa tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), nimeä 5 Suomen maakuntaa 10:ssä sekunnissa tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), sano kaksi legendaarista one-lineria Terminator elokuvasarjasta tai juo \(getNumber(input: 3)) huikkaa"
        ]
        
        self.tier2 = [
            "\(player1), halaa pelaajaa \(player2)",
            "\(player1), kerro vitsi. Jos muut pelaajat eivät naura, juo \(getNumber(input: 2)) huikkaa",
            "\(player1), niin monta punnerrusta kuin sinä teet, \(player2) ottaa huikkia",
            "Kertokaa tarina sana kerrallaan, se joka jäätyy ekana juo \(getNumber(input: 3)) huikkaa",
            "\(player1), ota 1 shotti",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "\(player1), tee 10 punnerrusta tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), ota tuijotuskilpailu pelaajan \(player2) kanssa. Häviäjä juo \(getNumber(input: 3)) huikkaa",
            "\(player1), imitoi leijonaa 15 sekunnin ajan",
            "\(player1), anna pelaajan \(player2) stailata hiuksesi loppu pelin ajaksi, tai juo 4 huikkaa",
            "\(player1), mikä on kiusallisin tilanne, johon olet joutunut? Vastaa tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), mikä on suurin fantasiasi? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), kerro paras iskurepliikkisi, jos muut eivät pidä sitä hauskana, juo \(getNumber(input: 2)) huikkaa",
            "\(player1), polvistu pelaajan \(player2) eteen ja kosi häntä, tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), kehrää kuin kissa 5 sekunnin ajan tai juo \(getNumber(input: 2)) huikkaa",
            "Seuraava pelaaja, joka nauraa ensimmäisenä, juo \(getNumber(input: 5)) huikkaa!",
            "\(player1), mene nurkkaan häpeämään kolmen vuoron ajaksi",
            "\(player1), mikä on penkkimaksimisi? Jaa \(getNumber(input: 1)) huikkaa jokaista kymmentä kiloa kohden",
            "\(player1), mikä on kyykkymaksimisi? Jaa \(getNumber(input: 1)) huikkaa jokaista kymmentä kiloa kohden"
        ]
        
        self.tier3 = [
            "Antakaa vuorotellen poskisuudelta oikealla istuvalle pelaajalle. Kieltäytyjälle \(getNumber(input: 5)) huikkaa",
            "\(player1), ota \(getNumber(input: 3)) huikkaa tai poskiläimäisy pelaajalta \(player2)",
            "\(player1), laita seuraavat ruumiinosat viehättävyysjärjestykseen: kainalot, varpaat, korvat",
            "\(player1), niin monta punnerrusta kuin sinä teet, \(player2) ottaa huikkia",
            "\(player1), röyhtäise tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), totuus vai tehtävä?",
            "\(player1), ota 1 shotti",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "\(player1), tee 10 punnerrusta tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), näytä viimeisin kuva puhelimesi ”Kätketyt”-albumista",
            "\(player1), ota paita pois loppupelin ajaksi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), näytä parhaimmat tanssiliikkeesi seuraavan 15 sekunnin ajan tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), näytä seksikkäin ilme minkä osaat tehdä",
            "\(player1), freestyle räppää aiheesta: ”Olen rakastunut pelaajaan \(player2)",
            "\(player1), riisu valitsemasi vaate tai ota \(getNumber(input: 4)) huikkaa",
            "\(player1), aina kun juot, voihki jokaisen hörpyn jälkeen loppupelin ajan",
            "\(player1), mikä on kiusallisin tilanne treffeillä, johon olet joutunut? Vastaa tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), paras kehonosa vastakkaisella sukupuolella?",
            "\(player1), anna pelaajan \(player2) kutittaa sinua 10 sekunnin ajan. Jos naurat, juo 3 huikkaa",
            "\(player1), flirttaile niin monella kielellä jotain järkevää kuin osaat. Jokaista kieltä kohden muut juovat \(getNumber(input: 2)) huikkaa",
            "\(player1), istu pelaajan \(player2) syliin kolmen vuoron ajaksi. \(getNumber(input: 4)) huikkaa",
            "\(player1), vaihda paitaa pelaajan \(player2) kanssa. Kieltäytymisestä \(getNumber(input: 4)) huikkaa"
        ]
        
        self.tier4 = [
            "\(player1), milloin menetit neitsyytesi?",
            "\(player1), vaihda housuja pelaajan \(player2) kanssa. Kieltäytymisestä \(getNumber(input: 4)) huikkaa",
            "\(player1), istu pelaajan \(player2) syliin loppupelin ajaksi. \(getNumber(input: 4)) huikkaa",
            "\(player1), oletko omasta mielestäsi hyvä sängyssä? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), milloin viimeksi harrastit seksiä?",
            "\(player1), milloin viimeksi masturboit?",
            "\(player1), näytä viimeisin lähettämäsi viesti tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), tee 10 punnerrusta tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), suutele edessäsi olevaa pelaajaa tai ota \(getNumber(input: 4)) huikkaa",
            "\(player1), ota 1 shotti",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "\(player1), oudoin asia jota olet tehnyt seksin aikana?",
            "\(player1), kuvaile viimeisintä katsomaasi aikuisviihdevideota",
            "\(player1), freestyle räppää aiheesta: ”Haluan harrastaa seksiä pelaajan \(player2) kanssa",
            "\(player1), riisu 2 valitsemaasi vaatetta tai ota \(getNumber(input: 4)) huikkaa",
            "\(player1), mikä on kiusallisin tilanne seksin aikana, johon olet joutunut? Vastaa tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), mikä on erikoisin paikka, jossa olet harrastanut seksiä? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), paras kehonosa pelaajalla \(player2)",
            "\(player1), mikä on suurin seksifantasiasi? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), haasta \(player2) kädenvääntöön. Häviäjä juo \(getNumber(input: 3)) huikkaa",
            "Kouraiskaa vuorotellen oikealla istuvan pelaajan haaraväliä. Kieltäytyjälle \(getNumber(input: 5)) huikkaa"
            
        ]
        
        self.tier5 = [
            "\(player1), milloin menetit neitsyytesi? Kerro yksityiskohtaisesti!",
            "\(player1), mene pelaajan \(player2) lusikkaan loppupelin ajaksi. Kieltäytymisestä \(getNumber(input: 4)) huikkaa",
            "\(player1), anna pelaajalle \(player2) sylitanssi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), tee 10 punnerrusta tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), ota 1 shotti",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "\(player1), kuvaile viimeisintä katsomaasi aikuisviihdevideota yksityiskohtaisesti",
            "\(player1), twerkkaa 10 sekuntia tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), riisuudu alusvaatteillesi loppupelin ajaksi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), riisu 3 valitsemaasi vaatetta tai ota \(getNumber(input: 4)) huikkaa",
            "\(player1), hyväile pelaajan \(player2) parasta kehonosaa 10 sekunnin ajan tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), nuolaise pelaajan \(player2) nänniä tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), näytä paljas takamuksesi tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), suutele pelaajaa \(player2) tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), pieraise tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), tee oudoin ääni jonka osaat tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), aiheuta myötähäpeä muille pelaajille seuraavan 15 sekunnin aikana tai juo \(getNumber(input: 6)) huikkaa",
            "\(player1), kaiva pelaajan \(player2) nenää tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), anna pelaajan \(player2) sylkäistä suuhusi tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), kenen pelaajan kanssa harrastaisit mieluiten seksiä? Vastaa tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), hiero molempia nännejäsi ja voihki 5 sekunnin ajan tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), ota pelaajan \(player2) jalka suuhusi tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), anna pelaajan player2 läimäistä sinua takamukselle tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), pyllistä muille pelaajille tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), laula kappaletta Ievan Polkka niin hyvin kuin osaat. Muut pelaajat päättävät suorituksesi perusteella, säästytkö \(getNumber(input: 3)) huikan rangaistukselta",
            "\(player1), jos siittimesi on tällä hetkellä pidempi kuin 10cm, juo \(getNumber(input: 3)) huikkaa (älä huijaa)",
            "\(player1), lausu Isä meidän -rukous virheettömästi. Jos epäonnistut, juo \(getNumber(input: 7)) huikkaa",
            "\(player1), esitä koiraa seuraavan 3 kierroksen ajan tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1) ja \(player2), kielisuudelkaa tai juokaa molemmat \(getNumber(input: 5)) huikkaa",
            "\(player1) ja \(player2), tuijotuskilpailu! Häviäjä juo \(getNumber(input: 3)) huikkaa",
            "\(player1), esitä apinaa seuraavan 3 kierroksen ajan tai juo \(getNumber(input: 4)) huikkaa",
            "Jokainen pelaaja on nauramatta! Se, joka nauraa ensimmäisenä, juo \(getNumber(input: 3)) huikkaa",
            "\(player1), tee 10 kainalopierua tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), anna fritsu pelaajalle \(player2). Kieltäytyjä juo \(getNumber(input: 5)) huikkaa"
        ]
    }
    
    //Kysymys
    
    func getTask(category: Int, tier: Int, index: Int) -> NSAttributedString {
        var taskArray: [String]
        
        if category == 2 {
            switch tier {
            case 1: taskArray = tier1
            case 2: taskArray = tier2
            case 3: taskArray = tier3
            case 4: taskArray = tier4
            case 5: taskArray = tier5
            default: taskArray = tier3
            }
        } else {
            if category == 0 {
                taskArray = normals
            } else {
                taskArray = dates
            }
        }
        
        var taskString: String
        
        if index < taskArray.count {
            taskString = taskArray[index]
        } else {
            taskString = taskArray.randomElement()!
        }
        
        let attributedString = attributedText(for: taskString, highlight1: player1, highlight2: player2, color1: color1, color2: color2)
        return attributedString
    }
    
    func attributedText(for fullText: String, highlight1: String, highlight2: String, color1: UIColor, color2: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Attributes for the highlighted texts
        let highlight1Attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color1,
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]
        let highlight2Attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color2,
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]
        
        // Apply attributes to highlight1
        let highlight1Range = (fullText as NSString).range(of: highlight1)
        if highlight1Range.location != NSNotFound {
            attributedString.addAttributes(highlight1Attributes, range: highlight1Range)
        }
        
        // Apply attributes to highlight2
        let highlight2Range = (fullText as NSString).range(of: highlight2)
        if highlight2Range.location != NSNotFound {
            attributedString.addAttributes(highlight2Attributes, range: highlight2Range)
        }
        
        return attributedString
    }
    
    func getNumber(input: Int) -> Int {
        let kerroin = (0.09735) * (drinkIndex * drinkIndex) + (0.15625)
        let amount = kerroin * Float(input)
        let finalNumber = amount.rounded()
        return Int(finalNumber)
        
    }
}

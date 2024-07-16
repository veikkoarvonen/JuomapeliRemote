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
    
    func getIndexesOld() -> [Int] {
        let demoTask = Task(player1: "", player2: "", drinkIndex: 1, color1: .red, color2: .red)
        var array: [Int] = []
        if gameCategory == 0 {
            array = Array(0..<demoTask.normals.count)
        } else if gameCategory == 1 {
            array = Array(0..<demoTask.dates.count)
        } else {
            let n1 = Array(0..<demoTask.tier1.count)
            let n2 = Array(0..<demoTask.tier2.count)
            let n3 = Array(0..<demoTask.tier3.count)
            let n4 = Array(0..<demoTask.tier4.count)
            let n5 = Array(0..<demoTask.tier5.count)
            var tiers = [n1, n2, n3, n4, n5]
            for i in 0..<tiers.count {
                tiers[i].shuffle()
            }
            
            let tierValues = getTiers()
            for i in 0..<tierValues.count {
            let tier = tierValues[i]
            let correctArray = tiers[tier - 1]
            let index = correctArray[i]
                array.append(index)
            }
        }
        array.shuffle()
        return array
    }
    
    func getIndexes() -> [Int] {
        let demoTask = Task(player1: "", player2: "", drinkIndex: 1, color1: .red, color2: .red)
        let n = demoTask.normals.count
        let d = demoTask.dates.count
        let t1 = demoTask.tier1.count
        let t2 = demoTask.tier2.count
        let t3 = demoTask.tier3.count
        let t4 = demoTask.tier4.count
        let t5 = demoTask.tier5.count
        
        var array: [Int] = []
        let tiers = getTiers()
        var usedIndices: Set<Int> = []
        var currentIndex: Int = 0
        var safety: Int = 0
        
        while array.count < 30 {
            var gap: Int
            if gameCategory == 0 {
                gap = n
            } else if gameCategory == 1 {
                gap = d
            } else {
                if currentIndex >= tiers.count {
                    break
                }
                switch tiers[currentIndex] {
                case 1: gap = t1
                case 2: gap = t2
                case 3: gap = t3
                case 4: gap = t4
                case 5: gap = t5
                default: gap = 0
                }
            }
            
            if gap == 0 {
                break
            }
            
            let index = Int.random(in: 0..<gap)
            if !usedIndices.contains(index) {
                array.append(index)
                usedIndices.insert(index)
                currentIndex += 1
            }
            
            safety += 1
            if safety > 500 {
                print("Safety break activated to prevent infinite loop.")
                break
            }
        }
        
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
        let indexes = getIndexes()
        
        print("Tiers: \(tiers)")
        print("Indexes: \(indexes)")
        
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
            "\(player1), laita seuraavat ruumiinosat viehättävyysjärjestykseen: kainalot, varpaat, korvat, tai juo \(getNumber(input: 2)) huikkaa",
            "\(player1), Telepatiahaaste! Yrittäkää sanoa pelaajan \(player2) kanssa sama sana samaan aikaan. Jos epäonnistutte juotte molemmat \(getNumber(input: 2)) huikkaa. Kategoria: väri",
            "\(player1), ota \(getNumber(input: 3)) huikkaa tai poskiläimäisy pelaajalta \(player2)",
            "\(player1), sano 5 kertaa putkeen ”floridan broileri ja reilu litra maitoa” ilman että kieli menee solmuun, tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), ota bodyshot pelaajalta \(player2)",
            "\(player1), demonstroi suosikki seksiasentosi pelaajan \(player2) kanssa",
            "\(player1), oudoin asia jota olet tehnyt seksin aikana? Vastaa tai juo 5 huikkaa",
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
            "\(player1), jos olisit peruna, tulisitko mielummin kuorituksi vai keitetyksi?",
            "\(player1), onko sinulla luurankoja kaapissa? Mitä ne ovat?",
            "\(player1), kauanko sinulla menee, että voit olla parisuhteessa täysin oma itsesi?",
            "\(player1), oletko mieluummin iso lusikka vai pikkulusikka?",
            "\(player1), oletko mieluummin alla vai päällä?",
            "\(player1), eskimosuutele pelaajaa \(player2)",
            "\(player1), kenen julkkiksen kanssa menisit naimisiin?",
            "\(player1), mistä pidät eniten kehossasi?",
            "\(player1), jos sinulla olisi 24 tuntia aikaa tuhlata miljoona euroa, mihin käyttäisit ne?",
            "\(player1), tulisitko mieluummin petetyksi vai pettäisitkö itse?",
            "\(player1), mikä koettelemus on vahvistanut sinua ihmisenä?",
            "\(player1), mitä päihteitä käytät/olet kokeillut?",
            "\(player1), uskotko kohtaloon?",
            "\(player1), missä haluaisit olla 10 vuoden päästä?",
            "\(player1), laita tärkeysjärjestykseen: raha, rakkaus, terveys, vapaus, turvallisuus",
            "\(player1), millaisia piirteitä arvostat kumppanissa eniten?",
            "\(player1), miten käsittelet riitatilanteita parisuhteessa?",
            "\(player1), miten osoitat rakkauttasi?",
            "\(player1), jos haluaisit karata näiltä treffeiltä ovelasti, miten tekisit sen olematta töykeä?",
            "\(player1), mikä biisi on soinut päässäsi viime aikoina?",
            "\(player1), mikä on kaikkien aikojen lempikappaleesi?",
            "\(player1), mikä adjektiivi kuvailisi sinua kaikista eniten?",
            "\(player1), kerro minulle jokin sisäpiirivitsisi kertomatta kontekstia",
            "\(player1), minkä vuosikymmenen/ajanjakson musiikki on mielestäsi parasta?",
            "\(player1), jos saisit valita, mihin maahan lentäisimme yhdessä heti huomenna?",
            "\(player1), uskotko horoskooppeihin?",
            "\(player1), uskotko Jumalaan?",
            "\(player1), mikä on paras neuvo, joka sinulle on annettu?",
            "\(player1), onko tärkeämpää omistaa 50 kaveria vai 2 hyvää ystävää?",
            "\(player1), mikä on jokin ärsyttävä piirre itsessäsi?",
            "\(player1), mikä on mieleenpainuvin kehu, jonka olet saanut?",
            "\(player1), miksi olet yhä sinkku?",
            "\(player1), jos voisit kertoa 10-vuotiaalle itsellesi jonkun neuvon, mikä se olisi?",
            "\(player1), kohtaisitko metsässä mieluummin miehen vai karhun?",
            "\(player1), oletko ikinä pissannut julkiseen uima-altaaseen?",
            "\(player1), mitä biisiä kuuntelet, kun olet surullinen?",
            "\(player1), oletko kateellinen kenellekään? Jos olet, kenelle ja miksi?",
            "\(player1), miten määrittelisit menestymisen?",
            "\(player1), mikä on mielestäsi paras tapa viettää laatuaikaa kahdestaan?",
            "\(player1), kuinka tärkeää seksi on sinulle?",
            "\(player1), mikä on parasta seksissä?",
            "\(player1), mikä on oudoin asia, jonka olet kokenut petipuuhissa?",
            "\(player1), oletko koskaan jättänyt tahallasi avaamatta toisen viestiä, jotta vaikuttaisit kiireiseltä?",
            "\(player1), mitä mieltä olet yhden illan jutuista?",
            "\(player1), mikä on suosikki seksiasentosi?",
            "\(player1), kuunteletko enemmän sydäntäsi vai päätäsi?",
            "\(player1), haluatko perustaa perheen joskus?",
            "\(player1), uskotko sielunkumppanuuteen?"
        ]
        
        self.tier1 = [
            "\(player1), nimeä viisi jediritaria Tähtiensota-elokuvista tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), jos olisit peruna, tulisitko mieluummin kuorituksi vai keitetyksi?",
            "Jokainen pelaaja, joka on alle 180cm pitkä, juo \(getNumber(input: 3)) huikkaa",
            "\(player1), niin monta punnerrusta kuin sinä teet, \(player2) ottaa huikkia",
            "\(player1), Telepatiahaaste! Yrittäkää sanoa pelaajan \(player2) kanssa sama sana samaan aikaan. Jos epäonnistutte juotte molemmat \(getNumber(input: 2)) huikkaa. Kategoria: väri",
            "Kertokaa tarina sana kerrallaan, se joka jäätyy ensimmäisena juo \(getNumber(input: 3)) huikkaa. Aloittakaa myötäpäivään pelaajasta \(player1)",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "\(player1), ota 1 shotti",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 3)) huikkaa",
            "\(player1), veikkaa, missä pisteessä jokainen pelaaja on seuraavan 5 vuoden aikana",
            "\(player1), nimeä 10 sekunnissa 5 maata jotka alkavat kirjaimella S tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), nimeä 10 disney-prinsessaa 15 sekunnissa tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), tee 10 punnerrusta tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), keksi jokaiselle pelaajalle uusi lempinimi",
            "\(player1), imitoi pelaajista valitsemaasi henkilöä niin pitkään, että joku arvaa ketä imitoit",
            "\(player1), kerro jokin paheesi tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), kuuluuko ananas pizzaan?, juo niin monta huikkaa kuin pelaajia on eri mieltä kanssasi",
            "\(player1), luettele suomalaisten aakkosten vokaalit takaperin. Jos epäonnistut, juo \(getNumber(input: 3)) huikkaa",
            "\(player1), mainitse jokin hyvä ominaisuus pelaajasta \(player2)",
            "\(player1), nimeä 4 James Bond -näyttelijää 10:ssä sekunnissa. Epäonnistumisesta \(getNumber(input: 3)) huikkaa",
            "\(player1), puhu niin monella kielellä jotain järkevää kuin osaat. Jokaista kieltä kohden muut juovat \(getNumber(input: 2)) huikkaa",
            "\(player1) päättää kategorian. Ensimmäinen joka ei osaa nimetä uutta asiaa, ottaa \(getNumber(input: 3)) huikkaa",
            "\(player1), sano 5 kertaa putkeen ”mustan kissan paksut posket” ilman että kieli menee solmuun, tai juo huikkaa",
            "\(player1), sano 5 kertaa putkeen ”käki istui keskellä keskioskaa” ilman että kieli menee solmuun, tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), sano 5 kertaa putkeen ”yksikseskös yskiskelet, itsekseskös itkeskelet” ilman että kieli menee solmuun, tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), nimeä 10 NATO-maata 10:ssä sekunnissa tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), nimeä 5 Suomen maakuntaa 10:ssä sekunnissa tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), sano kaksi legendaarista one-lineria Terminator-elokuvasarjasta tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), keksi lempinimi jokaiselle pelaajalle",
            "\(player1), haasta pelaaja \(player2) kivi, paperi, sakset -peliin. Häviäjälle \(getNumber(input: 3)) huikkaa",
            "\(player1), imitoi jotain näyttelijää 10 sekunnin ajan",
            "\(player1), Kerro jokin biisi, jota inhoat? Vastaa tai juo \(getNumber(input: 2)) huikkaa.",
            "Vesiputous! \(player1) aloittaa. Edetkää myötäpäivään",
            "\(player1), sano 5 kertaa putkeen ”floridan broileri ja reilu litra maitoa” ilman että kieli menee solmuun, tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), Millainen oli ensisuudelmasi? Vastaa tai juo \(getNumber(input: 3)) huikkaa.",
            "\(player1), Kuka on kuumin tietämäsi julkkis? Vastaa tai juo \(getNumber(input: 3)) huikkaa.",
            "\(player1), Kuka on kuuluisin henkilö, kenen numero sinulla on? Vastaa tai juo \(getNumber(input: 3)) huikkaa.",
            "Jokainen pelaaja laulaa sana kerrallaan Juice Leskisen kappaletta Ei tippa tapa. Se, joka jäätyy ensimmäisenä, juo \(getNumber(input: 3)) huikkaa. ”\(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan PMMP:n kappaletta Rusketusraidat. Se, joka jäätyy ensimmäisenä, juo \(getNumber(input: 3)) huikkaa. ”\(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan kappaletta Minttu sekä Ville. Se, joka jäätyy ensimmäisenä, juo \(getNumber(input: 3)) huikkaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan Mirellan kappaletta Timanttei. Se, joka jäätyy ensimmäisenä, juo \(getNumber(input: 3)) huikkaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan Kasmirin kappaletta Vadelmavene. Se, joka jäätyy ensimmäisenä, juo \(getNumber(input: 3)) huikkaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan Käärijän kappaletta Cha cha cha. Se, joka jäätyy ensimmäisenä, juo \(getNumber(input: 3)) huikkaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan JVG:n kappaletta Ikuinen vappu. Se, joka jäätyy ensimmäisenä, juo \(getNumber(input: 3)) huikkaa. \(player1) aloittaa",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 3)) huikkaa",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 4)) huikkaa",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 5)) huikkaa",
            "\(player1), ota \(getNumber(input: 3)) huikkaa",
            "\(player1), ota \(getNumber(input: 4)) huikkaa",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "Pelaaja, jolla on pienin jalka, juo \(getNumber(input: 3)) huikkaa",
            "Pelkäättekö enemmän korkeita vai ahtaita paikkoja? Äänestäkää! Vähemmistö ottaa \(getNumber(input: 4)) huikkaa"
        ]
        
        self.tier2 = [
            "\(player1), Mikä on pisin aikasi pesemättä hampaita? Vastaa tai juo \(getNumber(input: 2)) huikkaa.",
            "Pelaaja, jolla on paras peppu, juo \(getNumber(input: 4)) huikkaa",
            "Pelaaja, jolla on isoin hauis, juo \(getNumber(input: 4)) huikkaa",
            "\(player1), et saa nauraa loppupelin ajan. Jos epäonnistut, juo \(getNumber(input: 5)) huikkaa",
            "\(player1), kerro jokin harvinianen asia, jota olet tehnyt. Kaikki ketkä eivät ole tehneet kyseistä asiaa, juovat \(getNumber(input: 3)) huikkaa",
            "\(player1), laita pelaajan \(player2) sukat käsiisi loppupelin ajaksi tai juo \(getNumber(input: 5)) huikkaa",
            "Jokainen pelaaja imitoi vauvan ääniä. Huonoiten suoriutunut juo \(getNumber(input: 3)) huikkaa",
            "\(player1), jos puhelimesi ruutuaika on suurempi kuin pelaajalla \(player2), juo \(getNumber(input: 3)) huikkaa. Muussa tapauksessa \(player2) juo \(getNumber(input: 3)) huikkaa.",
            "\(player2), kerro jokin mielenkiintoinen fakta. Kaikki ketkä eivät tienneet sitä, juovat \(getNumber(input: 2)) huikkaa",
            "\(player1), laita seuraavat ruumiinosat viehättävyysjärjestykseen: kainalot, varpaat, korvat, tai juo \(getNumber(input: 2)) huikkaa",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 3)) huikkaa",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 4)) huikkaa",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 5)) huikkaa",
            "\(player1), ota \(getNumber(input: 3)) huikkaa",
            "\(player1), ota \(getNumber(input: 4)) huikkaa",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "Vesiputous! \(player1) aloittaa. Edetkää vastapäivään",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 4)) huikkaa",
            "\(player1), imitoi jotain vastapelaajista 10 sekunnin ajan",
            "\(player1), haasta pelaaja \(player2) peukalopainiin. Häviäjälle \(getNumber(input: 3)) huikkaa",
            "\(player1), keksi hauska lempinimi jokaiselle pelaajalle",
            "\(player1), halaa pelaajaa \(player2)",
            "\(player1), kerro vitsi. Jos muut pelaajat eivät naura, juo \(getNumber(input: 2)) huikkaa",
            "\(player1), niin monta punnerrusta kuin sinä teet, \(player2) ottaa huikkia",
            "\(player1), ota 1 shotti",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "\(player1), tee 10 punnerrusta tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), ota tuijotuskilpailu pelaajan \(player2) kanssa. Häviäjä juo \(getNumber(input: 3)) huikkaa",
            "\(player1), imitoi leijonaa 15 sekunnin ajan",
            "\(player1), anna pelaajan \(player2) stailata hiuksesi loppu pelin ajaksi, tai juo 4 huikkaa",
            "\(player1), mikä on kiusallisin tilanne, johon olet joutunut? Vastaa tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), imitoi jotain julkkista kunnes muut pelaajat arvaavat ketä esität. Jos epäonnistut, juo \(getNumber(input: 4)) huikkaa",
            "\(player1), mikä on suurin fantasiasi? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), kerro paras iskurepliikkisi, jos muut eivät pidä sitä hauskana, juo \(getNumber(input: 2)) huikkaa",
            "Jokainen pelaaja päästää vuorollaan oudon äänen. Kieltäytyjä juo \(getNumber(input: 4)) huikkaa",
            "\(player1), polvistu pelaajan \(player2) eteen ja kosi häntä, tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), kehrää kuin kissa 5 sekunnin ajan tai juo \(getNumber(input: 2)) huikkaa",
            "Seuraava pelaaja, joka nauraa ensimmäisenä, juo \(getNumber(input: 5)) huikkaa!",
            "\(player1), mene nurkkaan häpeämään kolmen vuoron ajaksi",
            "\(player1), Kerro jokin petipuuhiin sopiva biisi tai juo \(getNumber(input: 3)) huikkaa.",
            "\(player1), freestyle räppää tästä illasta. Muut pelaajat ovat tuomaristo ja päättävät, selviätkö rangaistukselta \(getNumber(input: 3)) huikkaa",
            "\(player1), yritä nuolaista kyynärpäääsi. Jos epäonnistut, juo \(getNumber(input: 2)) huikkaa",
            "\(player1), mikä on penkkimaksimisi? Jaa \(getNumber(input: 1)) huikkaa jokaista kymmentä kiloa kohden",
            "\(player1), Telepatiahaaste! Yrittäkää sanoa pelaajan \(player2) kanssa sama sana samaan aikaan. Jos epäonnistutte juotte molemmat \(getNumber(input: 2)) huikkaa. Kategoria: alkoholijuoma",
            "\(player1), anna paras Hessu Hopo -imitaatiosi tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), soita ilmakitaraa 15 sekunnin ajan tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), saat puhua vain kuiskaten seuraavan 3 kierroksen ajan. Jos epäonnistut, juo \(getNumber(input: 3)) huikkaa",
            "\(player1), yritä saada muut pelaajat nauramaan puhumatta. Jos epäonnistut, juo \(getNumber(input: 3)) huikkaa",
            "\(player1), esitä vauvaa seuraavan \(getNumber(input: 3)) kierroksen ajan tai juo \(getNumber(input: 4)) huikkaa",
            "Jokainen pelaaja imitoi jotain eläintä vuorollaan. Huonoiten suoriutunut juo \(getNumber(input: 3)) huikkaa",
            "\(player1), hyppää niin korkealle kuin pystyt. Jos muut pelaajat ovat vakuuttuneita, säästyt \(getNumber(input: 3)) huikan rangaistukselta",
           
            "\(player1), mene lankku-asentoon minuutiksi. Jos epäonnistut, juo \(getNumber(input: 5)) huikkaa",
            "\(player1), laula oopperaa 10 sekunnin ajan tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), hyräile valitsemaasi biisiä. Jos muut pelaajat eivät 15 sekunnissa arvaa mikä kappale on kyseessä, juo \(getNumber(input: 3)) huikkaa",
            "\(player1), mikä on kyykkymaksimisi? Jaa \(getNumber(input: 1)) huikkaa jokaista kymmentä kiloa kohden"
        ]
        
        self.tier3 = [
            "\(player1), Mikä on pisin aikasi ilman suihkua? Vastaa tai juo \(getNumber(input: 3)) huikkaa.",
            "Voiko pettämisen antaa anteeksi? Äänestäkää! Vähemmistö ottaa \(getNumber(input: 4)) huikkaa",
            "\(player1), nuolaise pelaajan \(player2) napaa tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), suutele jokaisen pelaajan nenää tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), keksi eroottinen lempinimi jokaiselle pelaajalle tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), riisu pelaajan \(player2) sukat tai juo \(getNumber(input: 3)) huikkaa",
            "Antakaa vuorotellen poskisuudelta oikealla istuvalle pelaajalle. Kieltäytyjälle \(getNumber(input: 5)) huikkaa",
            "\(player1), kuiskaa salaisuus pelaajalle \(player2). Jos hän ei reagoi mitenkään, juo \(getNumber(input: 2)) huikkaa",
            "\(player1), mikä on suurin fantasiasi? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), puhu kolmen kierroksen ajan ilman, että huulesi koskettavat. Jos epäonnistut, juo \(getNumber(input: 3)) huikkaa",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 3)) huikkaa",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 4)) huikkaa",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 5)) huikkaa",
            "\(player1), ota \(getNumber(input: 3)) huikkaa",
            "\(player1), ota \(getNumber(input: 4)) huikkaa",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "\(player1), sulje silmät ja ojenna etusormesi. \(player2) laittaa valitsemansa ruumiinosan sormeasi vasten. Jos arvaat, mikä ruumiinosa on kyseessä, säästyt \(getNumber(input: 4)) huikalta",
            "Jokainen pelaaja voihkaisee kerran. \(player1) aloittaa",
            "\(player1), anna 30 sekunnin jalkahieronta pelaajalle \(player2) tai ota \(getNumber(input: 4)) huikkaa",
            "\(player1), ota \(getNumber(input: 3)) huikkaa tai poskiläimäisy pelaajalta \(player2)",
            "\(player1), laita seuraavat ruumiinosat viehättävyysjärjestykseen: kainalot, varpaat, korvat",
            "\(player1), niin monta punnerrusta kuin sinä teet, \(player2) ottaa huikkia",
            "\(player1), röyhtäise tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), totuus vai tehtävä?",
            "\(player1), ota 1 shotti",
            "\(player1), jos sinun pitäisi harrastaa roolileikkiä pelaajan \(player2) kanssa, miksi pukeutuisitte?",
            "\(player1), Oletko ihastunut kehenkään tällähetkellä? Vastaa tai juo \(getNumber(input: 3)) huikkaa.",
            "\(player1), Oletko ikinä syönyt räkää? Vastaa tai juo \(getNumber(input: 4)) huikkaa.",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "\(player1), tee 10 punnerrusta tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), näytä viimeisin kuva puhelimesi ”Kätketyt”-albumista",
            "\(player1), ota paita pois loppupelin ajaksi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), näytä parhaimmat tanssiliikkeesi seuraavan 15 sekunnin ajan tai juo \(getNumber(input: 5)) huikkaa",
            "Jokainen pelaaja laulaa sana kerrallaan Juice Leskisen kappaletta Ei tippa tapa. Se, joka jäätyy ensimmäisenä, juo \(getNumber(input: 3)) huikkaa. ”\(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan PMMP:n kappaletta Rusketusraidat. Se, joka jäätyy ensimmäisenä, juo \(getNumber(input: 3)) huikkaa. ”\(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan kappaletta Minttu sekä Ville. Se, joka jäätyy ensimmäisenä, juo \(getNumber(input: 3)) huikkaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan Mirellan kappaletta Timanttei. Se, joka jäätyy ensimmäisenä, juo \(getNumber(input: 3)) huikkaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan Kasmirin kappaletta Vadelmavene. Se, joka jäätyy ensimmäisenä, juo \(getNumber(input: 3)) huikkaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan Käärijän kappaletta Cha cha cha. Se, joka jäätyy ensimmäisenä, juo \(getNumber(input: 3)) huikkaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan JVG:n kappaletta Ikuinen vappu. Se, joka jäätyy ensimmäisenä, juo \(getNumber(input: 3)) huikkaa. \(player1) aloittaa",
            "\(player1) ja \(player2), pitäkää toisianne kädestä kiinni loppupelin ajan. Jos kätenne irtoaa kesken pelin, juokaa molemmat \(getNumber(input: 5)) huikkaa",
            "\(player1), näytä seksikkäin ilme minkä osaat tehdä",
            "\(player1), freestyle räppää aiheesta: ”Olen rakastunut pelaajaan \(player2)",
            "\(player1), riisu valitsemasi vaate tai ota \(getNumber(input: 4)) huikkaa",
            "\(player1), leikkaa saksilla pieni pala hiuksiasi tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), aina kun juot, voihki jokaisen hörpyn jälkeen loppupelin ajan",
            "\(player1), mikä on kiusallisin tilanne treffeillä, johon olet joutunut? Vastaa tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), paras kehonosa vastakkaisella sukupuolella? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), anna pelaajan \(player2) kutittaa sinua 10 sekunnin ajan. Jos naurat, juo \(getNumber(input: 3)) huikkaa",
            "\(player1), flirttaile niin monella kielellä jotain järkevää kuin osaat. Jokaista kieltä kohden muut juovat \(getNumber(input: 2)) huikkaa",
            "\(player1), istu pelaajan \(player2) syliin kolmen vuoron ajaksi. Kieltäytyjälle \(getNumber(input: 4)) huikkaa",
            "Juo \(getNumber(input: 3)) huikkaa, jos voisit harrastaa seksiä jonkun huoneessa olevan kanssa (ole rehellinen)",
            "\(player1), vastaa kaikkeen ”kyllä” seuraavan minuutin ajan tai juo 5 huikkaa",
            "\(player1), Montaako ihmistä olet suudellut? Vastaa tai juo \(getNumber(input: 3)) huikkaa.",
            "\(player1), oletko omasta mielestäsi hyvä sängyssä? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), Mikä on isoin asia, josta olet valehdellut?? Vastaa tai juo \(getNumber(input: 3)) huikkaa.",
            "\(player1), näytä ahegao-ilmeesi tai juo \(getNumber(input: 4)) huikkaa",
            "Jokainen pelaaja esittelee itsensä mahdollisimman seksikkäästi. Kieltäytyjä/alisuoriutuja juo \(getNumber(input: 4)) huikkaa",
            "\(player1) ja \(player2), vaihtakaa vaatteet keskenänne loppupelin ajaksi (alkkareita lukuunottamatta). Kieltäytyjä juo 7 huikkaa",
            "Jokainen pelaaja nimeää vuorollaan jonkun seksilelun tai -välineen. Se, joka jäätyy ensimmäisenä, juo \(getNumber(input: 4)) huikkaa. \(player1) aloittaa",
            "\(player1), haista pelaajan \(player2) korvia tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), vaihda paitaa pelaajan \(player2) kanssa. Kieltäytymisestä \(getNumber(input: 4)) huikkaa"
        ]
        
        self.tier4 = [
            "\(player1), milloin menetit neitsyytesi? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), vaihda housuja pelaajan \(player2) kanssa. Kieltäytymisestä \(getNumber(input: 4)) huikkaa",
            "\(player1), istu pelaajan \(player2) syliin loppupelin ajaksi. Kieltäytyjälle \(getNumber(input: 4)) huikkaa",
            "\(player1), kuori banaani varpaillasi tai ota \(getNumber(input: 4)) huikkaa",
            "\(player1), mikä on erikoisin paikka, jossa olet harrastanut seksiä? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), yritä laittaa pelaajan \(player2) nyrkki omaan suuhusi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 3)) huikkaa",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 4)) huikkaa",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 5)) huikkaa",
            "\(player1), ota \(getNumber(input: 3)) huikkaa",
            "\(player1), ota \(getNumber(input: 4)) huikkaa",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "\(player1), anna muille pelaajille viehättävä, 15 sekunnin napatanssi-esitys tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), näytä orgasmi-ilmeesi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), syö banaani vietteliäästi tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), oletko omasta mielestäsi hyvä sängyssä? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), milloin viimeksi harrastit seksiä? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), milloin viimeksi masturboit? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), näytä viimeisin lähettämäsi viesti tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), tee 10 punnerrusta tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), suutele edessäsi olevaa pelaajaa tai ota \(getNumber(input: 4)) huikkaa",
            "\(player1), Telepatiahaaste! Yrittäkää sanoa pelaajan \(player2) kanssa sama sana samaan aikaan. Jos epäonnistutte juotte molemmat \(getNumber(input: 2)) huikkaa. Kategoria: seksiasento",
            "\(player1), ota 1 shotti",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "\(player1), oudoin asia jota olet tehnyt seksin aikana? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), kuvaile viimeisintä katsomaasi aikuisviihdevideota tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), freestyle räppää aiheesta: ”Haluan harrastaa seksiä pelaajan \(player2) kanssa",
            "\(player1), riisu 2 valitsemaasi vaatetta tai ota \(getNumber(input: 4)) huikkaa",
            "\(player1), mikä on kiusallisin tilanne seksin aikana, johon olet joutunut? Vastaa tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), mikä on erikoisin paikka, jossa olet harrastanut seksiä? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), paras kehonosa pelaajalla \(player2) Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), mikä on suurin seksifantasiasi? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), haasta \(player2) kädenvääntöön. Häviäjä juo \(getNumber(input: 3)) huikkaa",
            "\(player1), Mitkä ovat huonoimmat treffit, joilla olet ollut? Vastaa tai juo \(getNumber(input: 4)) huikkaa.",
            "Kaikki pelaajat joilla on siitin, juovat \(getNumber(input: 3)) huikkaa",
            "\(player1), riisu pelaajan \(player2) paita tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), Mikä on body-counttisi? Vastaa tai juo \(getNumber(input: 4)) huikkaa.",
            "\(player1), Milloin viimeksi harrastit seksiä? Vastaa tai juo \(getNumber(input: 5)) huikkaa.",
            "\(player1), onko koolla väliä? Vastaa tai juo \(getNumber(input: 4)) huikkaa",
            "Jokainen pelaaja suutelee vasemmalla puolellaan olevaa pelaajaa. Kieltäytymisestä \(getNumber(input: 4)) huikkaa",
            "\(player1), laske housusi ja nosta alkkarisi niin ylös kuin pystyt, tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), imitoi seksiä harrastavaa kilpikonnaa. Juo \(getNumber(input: 3)) huikkaa, jos imitaatiosi ei miellytä muita pelaajia",
            "\(player1) ja \(player2), tehkää fritsut toistenne rintakehään. Kieltäytyjä juo \(getNumber(input: 5)) huikkaa",
            "\(player1), kenen pelaajan kanssa harrastaisit mieluiten seksiä? Vastaa rehellisesti tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), laita housusi väärinpäin jalkaan loppupelin ajaksi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), nylkytä pelaajan \(player2) jalkaa 10 sekunnin ajan tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), julkaise kuva pyllystäsi someen tai juo \(getNumber(input: 4)) huikkaa. Saat pitää housut jalassa",
            "Kouraiskaa vuorotellen oikealla istuvan pelaajan haaraväliä. Kieltäytyjälle \(getNumber(input: 5)) huikkaa. \(player1) aloittaa."
            
        ]
        
        self.tier5 = [
            "\(player1), riisu pelaajan \(player2) housut tai juo \(getNumber(input: 3)) huikkaa",
            "\(player1), milloin, missä ja miten menetit neitsyytesi? Kerro yksityiskohtaisesti tai ota \(getNumber(input: 5)) huikkaa",
            "\(player1), mene pelaajan \(player2) lusikkaan loppupelin ajaksi. Kieltäytymisestä \(getNumber(input: 4)) huikkaa",
            "\(player1), anna pelaajalle \(player2) sylitanssi tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), tee 10 punnerrusta tai juo \(getNumber(input: 4)) huikkaa",
            "\(player1), ota 1 shotti",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 3)) huikkaa",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 4)) huikkaa",
            "\(player1), päätä, kuka pelaajista juo \(getNumber(input: 5)) huikkaa",
            "\(player1), ota \(getNumber(input: 3)) huikkaa",
            "\(player1), ota \(getNumber(input: 4)) huikkaa",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "\(player1), Telepatiahaaste! Yrittäkää sanoa pelaajan \(player2) kanssa sama sana samaan aikaan. Jos epäonnistutte juotte molemmat \(getNumber(input: 2)) huikkaa. Kategoria: seksilelu",
            "\(player1), ota \(getNumber(input: 5)) huikkaa",
            "\(player1), kuvaile viimeisintä katsomaasi aikuisviihdevideota yksityiskohtaisesti tai ota \(getNumber(input: 5))",
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
            "\(player1), anna pelaajan \(player2) läimäistä sinua takamukselle tai juo \(getNumber(input: 4)) huikkaa",
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
            "\(player1), rummuta Aakkoslaulun melodia pelaajan \(player2) pakaroilla. Kieltäytyjä juo \(getNumber(input: 5)) huikkaa",
            "\(player1) ja \(player2), dry humpatkaa keskenänne 10 sekunnin ajan. Kieltäytyjä juo \(getNumber(input: 6)) huikkaa",
            "Lyhin pelaaja juo \(getNumber(input: 3)) huikkaa",
            "\(player1), ota suu täyteen juomaa ja siirrä nesteet omasta suustasi pelaajan \(player2) suuhun. Kieltäytyjä juo \(getNumber(input: 5)) huikkaa",
            "\(player1), ja \(player2), vaihtakaa alusvaatteenne keskenänne. Kieltäytyjä juo \(getNumber(input: 6)) huikkaa",
            "\(player1), näytä tissit tai juo \(getNumber(input: 5)) huikkaa",
            "\(player1), näytä siittimesi tai juo \(getNumber(input: 6)) huikkaa. Jos et omista siitintä, juo \(getNumber(input: 2)) huikkaa",
            "\(player1), anna fritsu pelaajalle \(player2). Kieltäytyjä juo \(getNumber(input: 5)) huikkaa"
        ]
        
    }
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



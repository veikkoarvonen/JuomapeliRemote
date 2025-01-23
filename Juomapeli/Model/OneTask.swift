//
//  OneTask.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 23.7.2024.
//

import UIKit

struct SingleTask {
    
    //pelaajat
    var player1: String
    var player2: String
    var color1: UIColor
    var color2: UIColor
    
    //Peliparametrit
    var category: Int
    var tier: Int
    var drinkValue: Float
    var taskIndex: Int
    
    //Kysymykset
    var normals: [String] = []
    var dates: [String] = []
    var tier1: [String] = []
    var tier2: [String] = []
    var tier3: [String] = []
    var tier4: [String] = []
    var tier5: [String] = []
    
    //Huikkamäärä
    func getNumber(input: Int) -> Int {
        let kerroin = (0.09735) * (drinkValue * drinkValue) + (0.15625)
        let amount = kerroin * Float(input)
        let finalNumber = amount.rounded()
        return Int(finalNumber)
        
    }
    
    func getTask() -> NSAttributedString {
        var taskArray: [String]
        
        if category == 0 {
            taskArray = normals
        } else if category == 1 {
            taskArray = dates
        } else {
            switch tier {
            case 1: taskArray = tier1
            case 2: taskArray = tier2
            case 3: taskArray = tier3
            case 4: taskArray = tier4
            case 5: taskArray = tier5
            default: taskArray = tier3
            }
        }
        
        guard taskIndex < taskArray.count else {
            print("Task index out of range!")
            return NSAttributedString(string: "Task index out of range")
        }
        
        let taskString = taskArray[taskIndex]
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
    
    init(player1: String, player2: String, color1: UIColor, color2: UIColor, category: Int, tier: Int, drinkValue: Float, taskIndex: Int) {
        self.player1 = player1
        self.player2 = player2
        self.color1 = color1
        self.color2 = color2
        self.category = category
        self.tier = tier
        self.drinkValue = drinkValue
        self.taskIndex = taskIndex
        
        self.normals = [
            
            //Ilmanen
            
            
            "\(player1), haista pelaajan \(player2) kainaloa tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), totuus vai tehtävä? \(player2) kysyy kysymyksen tai antaa tehtävän vastauksesi perusteella",
            "\(player1), ota 5 rankaisevaa",
            "\(player1), ota rankaiseva ilman käsiä",
            "\(player1), kerro vitsi. Jos muut pelaajat eivät naura, ota \(getNumber(input: 2)) rankaisevaa",
            "\(player1), demonstroi suosikki seksiasentosi pelaajan \(player2) kanssa",
            "\(player1), Telepatiahaaste! Yrittäkää sanoa pelaajan \(player2) kanssa sama sana samaan aikaan. Jos epäonnistutte otatte molemmat \(getNumber(input: 2)) rankaisevaa. Kategoria: väri",
            "\(player1), aina kun kiroilet, ota rankaiseva loppupelin ajan",
            "\(player1), yritä saada pelaaja \(player2) nauramaan 30 sekunnin aikana. Jos epäonnistut, ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), ota paita pois loppupelin ajaksi tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), puhu kolmen kierroksen ajan ilman, että huulesi koskettavat. Jos epäonnistut, ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), yritä saada muut pelaajat nauramaan puhumatta. Jos epäonnistut, ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), anna paras Hessu Hopo -imitaatiosi tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), jos sinun pitäisi harrastaa roolileikkiä pelaajan \(player2) kanssa, miksi pukeutuisitte? Vastaa tai ota 3 rankaisevaa",
            "\(player1), ota \(getNumber(input: 3)) rankaisevaa tai poskiläimäisy pelaajalta \(player2)",
            "\(player1), oletko omasta mielestäsi hyvä sängyssä? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), kuiskaa salaisuus pelaajalle \(player2). Jos hän ei reagoi mitenkään, ota 2 rankaisevaa",
            "Kertokaa tarina sana kerrallaan, se joka jäätyy ekana ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), sano 5 kertaa putkeen ”floridan broileri ja reilu litra maitoa” ilman että kieli menee solmuun, tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), ota rangaistus pelaajan \(player2) navasta",
            "\(player1), seuraavan 3 kierroksen ajan, saat puhua vain suu kiinni. Jos epäonnistut, ota 3 rankaisevaa",
            "\(player1), ota housut pois loppupelin ajaksi tai \(getNumber(input: 4)) rankaisevaa",
            "\(player1), suutele edessäsi olevaa pelaajaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), kuvaile viimeisintä katsomaasi aikuisviihdevideota tai ota 6 rankaisevaa",
            "\(player1), ota tuijotuskilpailu pelaajan \(player2) kanssa. Häviäjä ottaa \(getNumber(input: 3)) rankaisevaa",
            "\(player1), ota pelaaja \(player2) reppuselkään ja tee 3 kyykkyä, tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), esitä känniläistä 15 sekuntia tai ota \(getNumber(input: 2)) rankaisevaa",
            "\(player1), näytä seksikkäin ilme minkä osaat tehdä tai ota 5 rankaisevaa",
            "\(player1), mikä on mielestäsi epäviehättävin kehonosa vastakkaisella sukupuolella? Vastaa tai ota 3 rankaisevaa",
            "\(player1), tee 10 punnerrusta tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 5)) rankaisevaa",
            
            //Kultatili
            
            
            
            
            
            
      
           
           
           
            "\(player1), röyhtäise tai ota \(getNumber(input: 3)) rankaisevaa",
         
            "\(player1), niin monta punnerrusta kuin sinä teet, \(player2) ottaa rankaisevia",
            "\(player1), freestyle-räppää tästä illasta. Muut pelaajat ovat tuomaristo ja päättävät, selviätkö rangaistukselta (\(getNumber(input: 3)) rankaisevaa)",
            "\(player1), nuolaise pelaajan \(player2) jalkaa tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), laita seuraavat ruumiinosat viehättävyysjärjestykseen: kainalot, varpaat, korvat, tai ota \(getNumber(input: 2)) rankaisevaa",
            
          
           
        
            
            "\(player1), oudoin asia jota olet tehnyt seksin aikana? Vastaa tai ota 5 rankaisevaa",
           
            "\(player1), onko sinulla fetissejä? Paljasta ne tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), soita exällesi tai ota \(getNumber(input: 4)) rankaisevaa",
            
            "\(player1), näytä viimeisin lähettämäsi viesti tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), imitoi muiden pelaajien valitsemaa julkkista tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), soita tutullesi ja sano että rakastat häntä",
           
            
            "\(player1), näytä viimeisin kuva puhelimesi ”Kätketyt” -albumista",
           
            "\(player1), anna pelaajalle \(player2) sylitanssi tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), anna pelaajan \(player2) laittaa sun someen jotain tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), juo raaka kananmuna tai ota \(getNumber(input: 3)) rankaisevaa",
            
            "\(player1), milloin viimeksi harrastit seksiä? Vastaa tai ota 5 rankaisevaa",
            "\(player1), milloin viimeksi masturboit? Vastaa tai ota 5 rankaisevaa",
           
            "\(player1), laula pelaajan \(player2) valitsemaa biisiä tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), näytä nänni tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), kerro salaisuus tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), oletko kiinnostunut kenestäkään? Vastaa tai ota 3 rankaisevaa",
            
           
     
            "\(player1), twerkkaa 10 sekuntia tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), anna paras Mikki Hiiri -imitaatiosi",
            
            
            "\(player1), vaihda vaatteita henkilön \(player2) kanssa tai ottakaa molemmat \(getNumber(input: 5)) rankaisevaa",
            "\(player1), seuraavan 3 kierroksen ajan, saat puhua vain laulaen",
          
            "\(player1), tyynyjuttele tyynylle 30 sekunnin ajan tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), keksi jokaiselle pelaajalle uusi lempinimi",
            "\(player1), imitoi leijonaa 15 sekunnin ajan",
            "\(player1), juo lasi vettä yhdellä kulauksella",
            "\(player1), ota 6 rankaisevaa",
            "\(player1), näytä parhaimmat tanssiliikkeesi seuraavan 15 sekunnin ajan tai ota \(getNumber(input: 5)) rankaisevaa",
           
            "\(player1), anna pelaajan \(player2) laittaa itsellesi huulipunaa loppupelin ajaksi",
            "\(player1), kerro nolo muisto",
            "\(player1), imitoi orgasmia 10 sekunnin ajan tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), ole loppupeli silmät sidottuna",
            "\(player1), freestyle-räppää aiheesta: ”Olen rakastunut pelaajaan \(player2)”",
            "\(player1), puhu pelaajalle \(player2) kuin vauvalle",
            "\(player1), soita vanhemmillesi ja kerro olevasi raskaana, tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), lähetä tuhmin mahdollinen tekstiviesti pelaajalle \(player2) vain emojeita käyttäen",
            "Ottakaa ryhmäkuva. Kieltäytyjä ottaa 4 rankaisevaa",
            "Ottakaa ryhmäkuva mahdollisimman rumilla ilmeillä. Kieltäytyjä ottaa 4 rankaisevaa",
            "\(player1), anna pelaajan \(player2) laittaa viestiä puhelimellasi valitsemalleen henkilölle",
            "\(player1), nimeä 10 sekunnissa 5 maata jotka alkavat kirjaimella S tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), nimeä 10 Disney-prinsessaa 15 sekunnissa tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), riisu pelaajan \(player2) sukat hampaillasi tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), mene ulos ja ulvo suden lailla tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), anna pelaajan \(player2) stailata hiuksesi loppu pelin ajaksi, tai ota 4 rankaisevaa",
            "\(player1), voihkaise aina ennen rankaisevaa loppupelin ajan",
            "\(player1), esitä apinaa 10 sekunnin ajan tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), haista pelaajan \(player2) kainaloa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), haista jokaisen pelaajan jalkoja ja kerro kenellä on pahin haju, tai ota \(getNumber(input: 6)) rankaisevaa",
            "\(player1), arvaa minkä väriset alushousut pelaajalla \(player2) on. Jos arvaat oikein, hän ottaa \(getNumber(input: 3)) rankaisevaa. Jos väärin, otat itse \(getNumber(input: 3))",
            "\(player1), soita ilmakitaraa 15 sekunnin ajan eläytyen tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), esitä robottia seuraavan 3 kierroksen ajan tai ota \(getNumber(input: 6)) rankaisevaa",
            "\(player1), imitoi pelaajista valitsemaasi henkilöä niin pitkään, että joku arvaa ketä imitoit",
            "\(player1), tee 10 kyykkyä samalla kun \(player2) makaa selällään allasi",
            "\(player1), murise seksikkäästi tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), anna 30 sekunnin jalkahieronta pelaajalle \(player2) tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), yritä laittaa pelaajan \(player2) nyrkki omaan suuhusi tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), yritä nuolaista kyynärpäätäsi. Jos epäonnistut, ota 2 rankaisevaa",
            "\(player1), kuori banaani varpaillasi tai ota \(getNumber(input: 4)) rankaisevaa",
            
            "\(player1), imitoi jotain julkkista kunnes muut pelaajat arvaavat ketä esität. Jos epäonnistut, ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), mene kolmen kierroksen ajaksi nurkkaan istumaan itseksesi tai ota 5 rankaisevaa",
            
            "\(player1), riisu 2 valitsemaasi vaatekappaletta tai ota \(getNumber(input: 4)) rankaisevaa",
            
            "\(player1), jos puhelimesi ruutuaika on suurempi kuin pelaajalla \(player2), ota \(getNumber(input: 3)) rankaisevaa. Muussa tapauksessa \(player2) ota itse \(getNumber(input: 3)) rankaisevaa",
            "\(player1), vastaa kaikkeen 'kyllä' seuraavan minuutin ajan tai ota 5 rankaisevaa",
            "\(player1), veikkaa, missä pisteessä jokainen pelaaja on seuraavan 5 vuoden aikana",
            "\(player1), saat puhua vain kuiskaten seuraavan 3 kierroksen ajan. Jos epäonnistut, ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), twerkkaa 15 sekunnin ajan tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), näytä orgasmi-ilmeesi tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), syö banaani viettelevästi tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), et saa nauraa loppupelin ajan. Jos epäonnistut, ota 5 rankaisevaa",
           
            "\(player1), päätä, kuka pelaajista ota 3 rankaisevaa",
            "\(player1), ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), ota 2 rankaisevaa",
            "\(player1), ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), paras kehonosa vastakkaisella sukupuolella?",
            "\(player1), ota kivi-sakset-paperi -matsi pelaajan \(player2) kanssa. Häviäjä ottaa \(getNumber(input: 3)) rankaisevaa",
            "Kaikki pelaajat, joilla on siitin, ottavat \(getNumber(input: 3)) rankaisevaa",
            "\(player1), jos olisit peruna, tulisitko mieluummin kuorituksi vai keitetyksi?",
            "\(player1), monenko ihmisen kanssa olet harrastanut seksiä? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), onko koolla väliä?",
            
            "\(player1), mikä on suurin fantasiasi? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), mikä on kiusallisin tilanne, johon olet joutunut? Vastaa tai ota \(getNumber(input: 3)) rankaisevaa",
      
            "\(player1), mikä on erikoisin paikka, jossa olet harrastanut seksiä? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
        ]
        
        self.dates = [
            "\(player1), kerro jokin red flag itsestäsi",
            "\(player1), kerro jokin red flag vastakkaisessa sukupuolessa",
            "\(player1), kerro jokin green flag vastakkaisessa sukupuolessa",
            "\(player1), tee jokin olettamus pelaajasta \(player2)",
            "Laittakaa huulenne vastakkain 3 sekunniksi, mutta älkää suudelko",
            "\(player1), kerro itsestäsi 2 totuutta ja yksi valhe. Jos \(player2) arvaa valheen, ottaa 3 rankaisevaa",
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
            "\(player1), sulje silmäsi. Minkä väriset silmät pelaajalla \(player2) on? Jos arvaat väärin, ota 3 rankaisevaa",
            "\(player1), jos sinun olisi pakko tatuoida jotain otsaasi, mitä se olisi?",
            "\(player1), onko sinulla yhtäkään fobiaa?",
            "\(player1), onko sinulla fetissejä? Jos kyllä, uskallatko kertoa pelaajalle \(player2) niistä?",
            "\(player1), demonstroi asento jossa yleensä nuku",
            "\(player1), jos olisitte kävelyllä ja \(player2) yhtäkkiä liukastuisi, nauraisitko vai olisitko huolissasi?",
            "\(player1), miten reagoisit, jos \(player2) kosisi sinua nyt?",
            "\(player1), kuuluuko ananas pizzaan?",
            "\(player1), mikä on spontaanein asia, jonka olet tehnyt?",
            "\(player1), näytä jokin uniikki taito jonka osaat. Jos et osaa mitään, ota 3 rankaisevaa",
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
            "\(player1), hiero pelaajan \(player2) hartioita 30 sekuntia tai ota 4 rankaisevaa",
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
            "\(player1), nimeä viisi Jediritaria Tähtiensota-elokuvista tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), jos olisit peruna, tulisitko mieluummin kuorituksi vai keitetyksi?",
            "Jokainen pelaaja, joka on alle 180 cm pitkä, ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), niin monta punnerrusta kuin sinä teet, \(player2) ottaa rankaisevia",
            "\(player1), Telepatiahaaste! Yrittäkää sanoa pelaajan \(player2) kanssa sama sana samaan aikaan. Jos epäonnistutte otatte molemmat \(getNumber(input: 2)) rankaisevaa. Kategoria: väri",
            "Kertokaa tarina sana kerrallaan. Pelaaja, joka jäätyy ensimmäisenä ottaa \(getNumber(input: 3)) rankaisevaa. Aloittakaa myötäpäivään pelaajasta \(player1)",
            "\(player1), ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), ota 7 rankaisevaa",
            "\(player1), päätä, kuka pelaajista ottaa \(getNumber(input: 3)) rankaisevaa",
            "\(player1), veikkaa, missä pisteessä jokainen pelaaja on seuraavan 5 vuoden päästä",
            "\(player1), nimeä 10 sekunnissa 5 maata jotka alkavat kirjaimella S tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), nimeä 10 Disney-prinsessaa 15 sekunnissa tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), tee 10 punnerrusta tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), keksi jokaiselle pelaajalle uusi lempinimi",
            "\(player1), imitoi pelaajista valitsemaasi henkilöä niin pitkään, että joku arvaa ketä imitoit",
            "\(player1), kerro jokin paheesi tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), kuuluuko ananas pizzaan?, ota niin monta rankaisevaa kuin pelaajia on eri mieltä kanssasi",
            "\(player1), luettele suomalaisten aakkosten vokaalit takaperin. Jos epäonnistut, ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), mainitse jokin hyvä ominaisuus pelaajassa \(player2)",
            "\(player1), nimeä 4 James Bond -näyttelijää 10:ssä sekunnissa. Epäonnistumisesta \(getNumber(input: 3)) rankaisevaa",
            "\(player1), puhu niin monella kielellä jotain järkevää kuin osaat. Jokaista kieltä kohden muut ottavat \(getNumber(input: 2)) rankaisevaa",
            "\(player1) päättää kategorian. Ensimmäinen joka ei osaa nimetä uutta asiaa, ottaa \(getNumber(input: 3)) rankaisevaa",
            "\(player1), sano 5 kertaa putkeen ”mustan kissan paksut posket” ilman että kieli menee solmuun, tai ota 4 rankaisevaa",
            "\(player1), sano 5 kertaa putkeen ”käki istui keskellä keskioksaa” ilman että kieli menee solmuun, tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), sano 5 kertaa putkeen ”yksikseskös yskiskelet, itsekseskös itkeskelet” ilman että kieli menee solmuun, tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), nimeä 10 NATO-maata 10:ssä sekunnissa tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), nimeä 5 Suomen maakuntaa 10:ssä sekunnissa tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), sano kaksi legendaarista one-lineria Terminator-elokuvasarjasta tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), keksi lempinimi jokaiselle pelaajalle",
            "\(player1), haasta pelaaja \(player2) kivi, paperi, sakset -peliin. Häviäjälle \(getNumber(input: 3)) rankaisevaa",
            "\(player1), imitoi jotain näyttelijää 10 sekunnin ajan",
            "\(player1), Kerro jokin biisi, jota inhoat? Vastaa tai ota \(getNumber(input: 2)) rankaisevaa.",
            "Vesiputous! \(player1) aloittaa. Edetkää myötäpäivään",
            "\(player1), sano 5 kertaa putkeen ”Floridan broileri ja reilu litra maitoa” ilman että kieli menee solmuun, tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), Millainen oli ensisuudelmasi? Vastaa tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), Kuka on kuumin tietämäsi julkkis? Vastaa tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), Kuka on kuuluisin henkilö, kenen numero sinulla on? Vastaa tai ota \(getNumber(input: 3)) rankaisevaa.",
            "Jokainen pelaaja laulaa sana kerrallaan Juice Leskisen kappaletta Ei tippa tapa. Se, joka jäätyy ensimmäisenä, ottaa \(getNumber(input: 3)) rankaisevaa. ”\(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan PMMP:n kappaletta Rusketusraidat. Se, joka jäätyy ensimmäisenä, ottaa \(getNumber(input: 3)) rankaisevaa. ”\(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan kappaletta Minttu sekä Ville. Se, joka jäätyy ensimmäisenä, ottaa \(getNumber(input: 3)) rankaisevaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan Mirellan kappaletta Timanttei. Se, joka jäätyy ensimmäisenä, ottaa \(getNumber(input: 3)) rankaisevaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan Kasmirin kappaletta Vadelmavene. Se, joka jäätyy ensimmäisenä, ottaa \(getNumber(input: 3)) rankaisevaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan Käärijän kappaletta Cha cha cha. Se, joka jäätyy ensimmäisenä, ottaa \(getNumber(input: 3)) rankaisevaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan JVG:n kappaletta Ikuinen vappu. Se, joka jäätyy ensimmäisenä, ottaa \(getNumber(input: 3)) rankaisevaa. \(player1) aloittaa",
            "\(player1), päätä, kuka pelaajista ottaa \(getNumber(input: 3)) rankaisevaa",
            "\(player1), päätä, kuka pelaajista ottaa \(getNumber(input: 4)) rankaisevaa",
            "\(player1), päätä, kuka pelaajista ottaa \(getNumber(input: 5)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 5)) rankaisevaa",
            "Pelaaja, jolla on pienin jalka, ottaa \(getNumber(input: 3)) rankaisevaa",
            "Pelkäättekö enemmän korkeita vai ahtaita paikkoja? Äänestäkää! Vähemmistö ottaa \(getNumber(input: 4)) rankaisevaa"
        ]
        
        self.tier2 = [
            "\(player1), Mikä on pisin aikasi pesemättä hampaita? Vastaa tai ota \(getNumber(input: 2)) rankaisevaa.",
            "Pelaaja, jolla on paras peppu, ottaa \(getNumber(input: 4)) rankaisevaa",
            "Pelaaja, jolla on isoin hauis, ottaa \(getNumber(input: 4)) rankaisevaa",
            "\(player1), et saa nauraa loppupelin ajan. Jos epäonnistut, ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), kerro jokin harvinianen asia, jota olet tehnyt. Kaikki ketkä eivät ole tehneet kyseistä asiaa, ottavat \(getNumber(input: 3)) rankaisevaa",
            "\(player1), laita pelaajan \(player2) sukat käsiisi loppupelin ajaksi tai ota \(getNumber(input: 5)) rankaisevaa",
            "Jokainen pelaaja imitoi vauvan ääniä. Huonoiten suoriutunut ottaa \(getNumber(input: 3)) rankaisevaa",
            "\(player1), jos puhelimesi ruutuaika on suurempi kuin pelaajalla \(player2), ota \(getNumber(input: 3)) rankaisevaa. Muussa tapauksessa \(player2) ottaa \(getNumber(input: 3)) rankaisevaa.",
            "\(player2), kerro jokin mielenkiintoinen fakta. Kaikki ketkä eivät tienneet sitä, ottavat \(getNumber(input: 2)) rankaisevaa",
            "\(player1), laita seuraavat ruumiinosat viehättävyysjärjestykseen: kainalot, varpaat, korvat, tai ota \(getNumber(input: 2)) rankaisevaa",
            "\(player1), päätä, kuka pelaajista ottaa \(getNumber(input: 3)) rankaisevaa",
            "\(player1), päätä, kuka pelaajista ottaa \(getNumber(input: 4)) rankaisevaa",
            "\(player1), päätä, kuka pelaajista ottaa \(getNumber(input: 5)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 5)) rankaisevaa",
            "Vesiputous! \(player1) aloittaa. Edetkää vastapäivään",
            "\(player1), päätä, kuka pelaajista ottaa \(getNumber(input: 4)) rankaisevaa",
            "\(player1), imitoi jotain vastapelaajista 10 sekunnin ajan",
            "\(player1), haasta pelaaja \(player2) peukalopainiin. Häviäjälle \(getNumber(input: 3)) rankaisevaa",
            "\(player1), keksi hauska lempinimi jokaiselle pelaajalle",
            "\(player1), halaa pelaajaa \(player2)",
            "\(player1), kerro vitsi. Jos muut pelaajat eivät naura, ota \(getNumber(input: 2)) rankaisevaa",
            "\(player1), niin monta punnerrusta kuin sinä teet, \(player2) ottaa rankaisevia",
            "\(player1), ota 6 rankaisevaa",
            "\(player1), ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), tee 10 punnerrusta tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), ota tuijotuskilpailu pelaajan \(player2) kanssa. Häviäjä ottaa \(getNumber(input: 3)) rankaisevaa",
            "\(player1), imitoi leijonaa 15 sekunnin ajan",
            "\(player1), anna pelaajan \(player2) stailata hiuksesi loppu pelin ajaksi, tai ota 4 rankaisevaa",
            "\(player1), mikä on kiusallisin tilanne, johon olet joutunut? Vastaa tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), imitoi jotain julkkista kunnes muut pelaajat arvaavat ketä esität. Jos epäonnistut, ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), mikä on suurin fantasiasi? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), kerro paras iskurepliikkisi, jos muut eivät pidä sitä hauskana, ota \(getNumber(input: 2)) rankaisevaa",
            "Jokainen pelaaja päästää vuorollaan oudon äänen. Kieltäytyjä ottaa \(getNumber(input: 4)) rankaisevaa",
            "\(player1), polvistu pelaajan \(player2) eteen ja kosi häntä, tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), kehrää kuin kissa 5 sekunnin ajan tai ota \(getNumber(input: 2)) rankaisevaa",
            "Seuraava pelaaja, joka nauraa ensimmäisenä, ottaa \(getNumber(input: 5)) rankaisevaa!",
            "\(player1), mene nurkkaan häpeämään kolmen vuoron ajaksi",
            "\(player1), Kerro jokin petipuuhiin sopiva biisi tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), freestyle-räppää tästä illasta. Muut pelaajat ovat tuomaristo ja päättävät, selviätkö rangaistukselta \(getNumber(input: 3)) rankaisevaa",
            "\(player1), yritä nuolaista kyynärpäääsi. Jos epäonnistut, ota \(getNumber(input: 2)) rankaisevaa",
            "\(player1), mikä on penkkimaksimisi? Jaa \(getNumber(input: 1)) rankaisevaa jokaista kymmentä kiloa kohden",
            "\(player1), Telepatiahaaste! Yrittäkää sanoa pelaajan \(player2) kanssa sama sana samaan aikaan. Jos epäonnistutte otatte molemmat \(getNumber(input: 2)) rankaisevaa. Kategoria: automerkki",
            "\(player1), anna paras Hessu Hopo -imitaatiosi tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), soita ilmakitaraa 15 sekunnin ajan tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), saat puhua vain kuiskaten seuraavan 3 kierroksen ajan. Jos epäonnistut, ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), yritä saada muut pelaajat nauramaan puhumatta. Jos epäonnistut, ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), esitä vauvaa seuraavan \(getNumber(input: 3)) kierroksen ajan tai ota \(getNumber(input: 4)) rankaisevaa",
            "Jokainen pelaaja imitoi jotain eläintä vuorollaan. Huonoiten suoriutunut ottaa \(getNumber(input: 3)) rankaisevaa",
            "\(player1), hyppää niin korkealle kuin pystyt. Jos muut pelaajat ovat vakuuttuneita, säästyt \(getNumber(input: 3)) rankaisevalta",
            
            "\(player1), mene lankku-asentoon minuutiksi. Jos epäonnistut, ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), laula oopperaa 10 sekunnin ajan tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), hyräile valitsemaasi biisiä. Jos muut pelaajat eivät 15 sekunnissa arvaa mikä kappale on kyseessä, ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), mikä on kyykkymaksimisi? Jaa \(getNumber(input: 1)) rankaisevaa jokaista kymmentä kiloa kohden"
        ]
        
        self.tier3 = [
            "\(player1), Mikä on pisin aikasi ilman suihkua? Vastaa tai ota \(getNumber(input: 3)) rankaisevaa.",
            "Voiko pettämisen antaa anteeksi? Äänestäkää! Vähemmistö ottaa \(getNumber(input: 4)) rankaisevaa",
            "\(player1), nuolaise pelaajan \(player2) napaa tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), suutele jokaisen pelaajan nenää tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), keksi eroottinen lempinimi jokaiselle pelaajalle tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), riisu pelaajan \(player2) sukat tai ota \(getNumber(input: 3)) rankaisevaa",
            "Antakaa vuorotellen poskisuudelma oikealla puolellanne istuvalle pelaajalle. Kieltäytyjälle \(getNumber(input: 5)) rankaisevaa",
            "\(player1), kuiskaa salaisuus pelaajalle \(player2). Jos hän ei reagoi mitenkään, ota \(getNumber(input: 2)) rankaisevaa",
            "\(player1), mikä on suurin fantasiasi? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), puhu kolmen kierroksen ajan ilman, että huulesi koskettavat. Jos epäonnistut, ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), päätä, kuka pelaajista ottaa \(getNumber(input: 3)) rankaisevaa",
            "\(player1), päätä, kuka pelaajista ottaa \(getNumber(input: 4)) rankaisevaa",
            "\(player1), päätä, kuka pelaajista ottaa \(getNumber(input: 5)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), sulje silmät ja ojenna etusormesi. \(player2) laittaa valitsemansa ruumiinosan sormeasi vasten. Jos arvaat, mikä ruumiinosa on kyseessä, säästyt \(getNumber(input: 4)) rankaisevalta",
            "Jokainen pelaaja voihkaisee kerran. \(player1) aloittaa",
            "\(player1), anna 30 sekunnin jalkahieronta pelaajalle \(player2) tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 3)) rankaisevaa tai poskiläimäisy pelaajalta \(player2)",
            "\(player1), laita seuraavat ruumiinosat viehättävyysjärjestykseen: kainalot, varpaat, korvat",
            "\(player1), niin monta punnerrusta kuin sinä teet, \(player2) ottaa rankaisevia",
            "\(player1), röyhtäise tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), totuus vai tehtävä?",
            "\(player1), ota 8 rankaisevaa",
            "\(player1), jos sinun pitäisi harrastaa roolileikkiä pelaajan \(player2) kanssa, miksi pukeutuisitte?",
            "\(player1), Oletko ihastunut kehenkään tällähetkellä? Vastaa tai ota \(getNumber(input: 3)) rankaisevaa.",
            "\(player1), Oletko ikinä syönyt räkää? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), tee 10 punnerrusta tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), näytä viimeisin kuva puhelimesi ”Kätketyt” -albumista",
            "\(player1), ota paita pois loppupelin ajaksi tai \(getNumber(input: 4)) rankaisevaa",
            "\(player1), näytä parhaimmat tanssiliikkeesi seuraavan 15 sekunnin ajan tai ota \(getNumber(input: 5)) rankaisevaa",
            "Jokainen pelaaja laulaa sana kerrallaan Juice Leskisen kappaletta Ei tippa tapa. Se, joka jäätyy ensimmäisenä, ottaa \(getNumber(input: 3)) rankaisevaa. ”\(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan PMMP:n kappaletta Rusketusraidat. Se, joka jäätyy ensimmäisenä, ottaa \(getNumber(input: 3)) rankaisevaa. ”\(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan kappaletta Minttu sekä Ville. Se, joka jäätyy ensimmäisenä, ottaa \(getNumber(input: 3)) rankaisevaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan Mirellan kappaletta Timanttei. Se, joka jäätyy ensimmäisenä, ottaa \(getNumber(input: 3)) rankaisevaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan Kasmirin kappaletta Vadelmavene. Se, joka jäätyy ensimmäisenä, ottaa \(getNumber(input: 3)) rankaisevaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan Käärijän kappaletta Cha cha cha. Se, joka jäätyy ensimmäisenä, ottaa \(getNumber(input: 3)) rankaisevaa. \(player1) aloittaa",
            "Jokainen pelaaja laulaa sana kerrallaan JVG:n kappaletta Ikuinen vappu. Se, joka jäätyy ensimmäisenä, ottaa \(getNumber(input: 3)) rankaisevaa. \(player1) aloittaa",
            "\(player1) ja \(player2), pitäkää toisianne kädestä kiinni loppupelin ajan. Jos kätenne irtoaa kesken pelin, ottakaa molemmat \(getNumber(input: 5)) rankaisevaa",
            "\(player1), näytä seksikkäin ilme minkä osaat tehdä",
            "\(player1), freestyle-räppää aiheesta: ”Olen rakastunut pelaajaan \(player2)",
            "\(player1), riisu valitsemasi vaate tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), leikkaa saksilla pieni pala hiuksiasi tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), voihkaise aina ennen rankaisevaa loppupelin ajan",
            "\(player1), mikä on kiusallisin tilanne treffeillä, johon olet joutunut? Vastaa tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), paras kehonosa vastakkaisella sukupuolella? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), anna pelaajan \(player2) kutittaa sinua 10 sekunnin ajan. Jos naurat, ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), flirttaile niin monella kielellä jotain järkevää kuin osaat. Jokaista kieltä kohden muut ottavat \(getNumber(input: 2)) rankaisevaa",
            "\(player1), istu pelaajan \(player2) syliin kolmen vuoron ajaksi. Kieltäytyjälle \(getNumber(input: 4)) rankaisevaa",
            "Ota \(getNumber(input: 3)) rankaisevaa, jos voisit harrastaa seksiä jonkun huoneessa olevan pelaajan kanssa",
            "\(player1), vastaa kaikkeen ”kyllä” seuraavan minuutin ajan tai ota 5 rankaisevaa",
            "\(player1), montaako ihmistä olet suudellut? Vastaa tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), oletko omasta mielestäsi hyvä sängyssä? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), mikä on isoin asia, josta olet valehdellut?? Vastaa tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), näytä ahegao-ilmeesi tai ota \(getNumber(input: 4)) rankaisevaa",
            "Jokainen pelaaja esittelee itsensä mahdollisimman seksikkäästi. Kieltäytyjä/alisuoriutuja ottaa \(getNumber(input: 4)) rankaisevaa",
            "\(player1) ja \(player2), vaihtakaa vaatteet keskenänne loppupelin ajaksi (alkkareita lukuunottamatta). Kieltäytyjä ottaa 7 rankaisevaa",
            "Jokainen pelaaja nimeää vuorollaan jonkun seksilelun tai -välineen. Se, joka jäätyy ensimmäisenä, ottaa \(getNumber(input: 4)) rankaisevaa. \(player1) aloittaa",
            "\(player1), haista pelaajan \(player2) korvia tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), vaihda paitaa pelaajan \(player2) kanssa. Kieltäytymisestä \(getNumber(input: 4)) rankaisevaa"
        ]
        
        self.tier4 = [
            "\(player1), milloin menetit neitsyytesi? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), vaihda housuja pelaajan \(player2) kanssa. Kieltäytymisestä \(getNumber(input: 4)) rankaisevaa",
            "\(player1), istu pelaajan \(player2) syliin loppupelin ajaksi. Kieltäytyjälle \(getNumber(input: 4)) rankaisevaa",
            "\(player1), kuori banaani varpaillasi tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), mikä on erikoisin paikka, jossa olet harrastanut seksiä? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), yritä laittaa pelaajan \(player2) nyrkki omaan suuhusi tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), päätä, kuka pelaajista saa \(getNumber(input: 3)) rankaisevaa",
            "\(player1), päätä, kuka pelaajista saa \(getNumber(input: 4)) rankaisevaa",
            "\(player1), päätä, kuka pelaajista saa \(getNumber(input: 5)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), anna muille pelaajille viehättävä, 15 sekunnin napatanssi-show tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), näytä orgasmi-ilmeesi tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), syö banaani vietteliäästi tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), oletko omasta mielestäsi hyvä sängyssä? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), milloin viimeksi harrastit seksiä? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), milloin viimeksi masturboit? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), näytä viimeisin lähettämäsi viesti tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), tee 10 punnerrusta tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), suutele edessäsi olevaa pelaajaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), Telepatiahaaste! Yrittäkää sanoa pelaajan \(player2) kanssa sama sana samaan aikaan. Jos epäonnistutte otatte molemmat \(getNumber(input: 2)) rankaisevaa. Kategoria: seksiasento",
            "\(player1), ota 7 rankaisevaa",
            "\(player1), ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), oudoin asia jota olet tehnyt seksin aikana? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), kuvaile viimeisintä katsomaasi aikuisviihdevideota tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), freestyle-räppää aiheesta: ”Haluan rakastella pelaajan \(player2) kanssa",
            "\(player1), riisu 2 valitsemaasi vaatekappaletta tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), mikä on kiusallisin tilanne seksin aikana, johon olet joutunut? Vastaa tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), mikä on erikoisin paikka, jossa olet harrastanut seksiä? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), paras kehonosa pelaajalla \(player2)? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), mikä on suurin seksifantasiasi? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), haasta \(player2) kädenvääntöön. Häviäjä ottaa \(getNumber(input: 3)) rankaisevaa",
            "\(player1), Mitkä ovat huonoimmat treffit, joilla olet ollut? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "Kaikki pelaajat joilla on siitin, ottavat \(getNumber(input: 3)) rankaisevaa",
            "\(player1), riisu pelaajan \(player2) paita tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), Mikä on body-counttisi? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), milloin viimeksi harrastit seksiä? Vastaa tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), onko koolla väliä? Vastaa tai ota \(getNumber(input: 4)) rankaisevaa",
            "Jokainen pelaaja suutelee vasemmalla puolellaan olevaa pelaajaa. Kieltäytymisestä \(getNumber(input: 4)) rankaisevaa",
            "\(player1), laske housusi ja nosta alkkarisi niin ylös kuin pystyt, tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), imitoi yhdynnässä olevaa kilpikonnaa. Ota \(getNumber(input: 3)) rankaisevaa, jos imitaatiosi ei miellytä muita pelaajia",
            "\(player1) ja \(player2), tehkää fritsut toistenne rintakehään. Kieltäytyjä ottaa \(getNumber(input: 5)) rankaisevaa",
            "\(player1), kenen pelaajan kanssa harrastaisit mieluiten seksiä? Vastaa rehellisesti tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), laita housusi väärinpäin jalkaan loppupelin ajaksi tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), nylkytä pelaajan \(player2) jalkaa 10 sekunnin ajan tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), julkaise kuva takamuksestasi someen tai ota \(getNumber(input: 4)) rankaisevaa. Saat pitää housut jalassa",
            "Kouraiskaa vuorotellen oikealla puolellanne istuvan pelaajan haaraväliä. Kieltäytyjälle \(getNumber(input: 5)) rankaisevaa. \(player1) aloittaa."
            
        ]
        
        self.tier5 = [
            "\(player1), riisu pelaajan \(player2) housut tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), milloin, missä ja miten menetit neitsyytesi? Kerro yksityiskohtaisesti tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), mene pelaajan \(player2) kanssa lusikkaan loppupelin ajaksi. Kieltäytymisestä \(getNumber(input: 4)) rankaisevaa",
            "\(player1), anna pelaajalle \(player2) sylitanssi tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), tee 10 punnerrusta tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), ota 7 rankaisevaa",
            "\(player1), päätä, kuka pelaajista ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), päätä, kuka pelaajista ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), päätä, kuka pelaajista ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), Telepatiahaaste! Yrittäkää sanoa pelaajan \(player2) kanssa sama sana samaan aikaan. Jos epäonnistutte otatte molemmat \(getNumber(input: 2)) rankaisevaa. Kategoria: seksilelu",
            "\(player1), ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), kuvaile viimeisintä katsomaasi aikuisviihdevideota yksityiskohtaisesti tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), twerkkaa 10 sekuntia tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), riisuudu alusvaatteillesi loppupelin ajaksi tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), riisu 3 valitsemaasi vaatekappaletta tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), hyväile pelaajan \(player2) parasta kehonosaa 10 sekunnin ajan tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), nuolaise pelaajan \(player2) nänniä tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), näytä paljas takamuksesi tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), suutele pelaajaa \(player2) tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), pieraise tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), tee oudoin ääni jonka osaat tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), aiheuta myötähäpeä muille pelaajille seuraavan 15 sekunnin aikana tai ota \(getNumber(input: 6)) rankaisevaa",
            "\(player1), kaiva pelaajan \(player2) nenää tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), anna pelaajan \(player2) sylkäistä suuhusi tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), kenen pelaajan kanssa harrastaisit mieluiten seksiä? Vastaa tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), hiero molempia nännejäsi ja voihki 5 sekunnin ajan tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), ota pelaajan \(player2) jalka suuhusi tai \(getNumber(input: 3)) rankaisevaa",
            "\(player1), anna pelaajan \(player2) läimäistä sinua takamukselle tai ota \(getNumber(input: 4)) rankaisevaa",
            "\(player1), pyllistä muille pelaajille tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), laula kappaletta Ievan Polkka niin hyvin kuin osaat. Muut pelaajat päättävät suorituksesi perusteella, säästytkö \(getNumber(input: 3)) rankaisevalta",
            "\(player1), jos siittimesi on tällä hetkellä pidempi kuin 10 cm, ota \(getNumber(input: 3)) rankaisevaa (älä huijaa)",
            "\(player1), lausu Isä meidän -rukous virheettömästi. Jos epäonnistut, ota \(getNumber(input: 7)) rankaisevaa",
            "\(player1), esitä koiraa seuraavan 3 kierroksen ajan tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1) ja \(player2), kielisuudelkaa tai ottakaa molemmat \(getNumber(input: 5)) rankaisevaa",
            "\(player1) ja \(player2), tuijotuskilpailu! Häviäjä ottaa \(getNumber(input: 3)) rankaisevaa",
            "\(player1), esitä apinaa seuraavan 3 kierroksen ajan tai ota \(getNumber(input: 4)) rankaisevaa",
            "Jokainen pelaaja on nauramatta! Se, joka nauraa ensimmäisenä, ottaa \(getNumber(input: 3)) rankaisevaa",
            "\(player1), tee 10 kainalopierua tai ota \(getNumber(input: 3)) rankaisevaa",
            "\(player1), rummuta Aakkoslaulun melodia pelaajan \(player2) pakaroilla. Kieltäytyjä ottaa \(getNumber(input: 5)) rankaisevaa",
            "\(player1) ja \(player2), dry humpatkaa keskenänne 10 sekunnin ajan. Kieltäytyjä ottaa \(getNumber(input: 6)) rankaisevaa",
            "Lyhin pelaaja ottaa \(getNumber(input: 3)) rankaisevaa",
            "\(player1), ota suu täyteen juomaa ja siirrä nesteet omasta suustasi pelaajan \(player2) suuhun. Kieltäytyjä ottaa \(getNumber(input: 5)) rankaisevaa",
            "\(player1), ja \(player2), vaihtakaa alusvaatteenne keskenänne. Kieltäytyjä ottaa \(getNumber(input: 6)) rankaisevaa",
            "\(player1), näytä tissit tai ota \(getNumber(input: 5)) rankaisevaa",
            "\(player1), näytä siittimesi tai ota \(getNumber(input: 6)) rankaisevaa. Jos et omista siitintä, ota \(getNumber(input: 2)) rankaisevaa",
            "\(player1), anna fritsu pelaajalle \(player2). Kieltäytyjä ottaa \(getNumber(input: 5)) rankaisevaa"
        ]
    }
}

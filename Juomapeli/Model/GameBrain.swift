//
//  GameBrain.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 26.6.2024.
//

import Foundation

struct GameBrain {
    
    var player1: String
    var player2: String
    var tasks: [String]
    
    init(player1: String, player2: String) {
        self.player1 = player1
        self.player2 = player2
        
        self.tasks = [
            "\(player1), totuus vai tehtävä?",
            "\(player1), suutele edessäsi olevaa pelaajaa tai ota 4 huikkaa",
            "\(player1), ota 5 huikkaa",
            "\(player1), ota 1 shotti",
            "\(player1), tee 10 punnerrusta tai juo 4 huikkaa",
            "\(player1), röyhtäise tai juo 3 huikkaa",
            "Kertokaa tarina sana kerrallaan, se joka jäätyy ekana juo 3 huikkaa",
            "\(player1), niin monta punnerrusta kuin sinä teet, \(player2) ottaa huikkia",
            "\(player1), freestyle räppää tästä illasta. Muut pelaajat ovat tuomaristo ja päättävät, selviätkö rangaistukselta (3 huikkaa)",
            "\(player1), nuolaise pelaajan Valeria jalkaa tai ota 3 huikkaa",
            "\(player1), laita seuraavat ruumiinosat viehättävyysjärjestykseen: kainalot, varpaat, korvat",
            "\(player1), Telepatiahaaste! Yrittäkää sanoa pelaajan \(player2) kanssa sama sana samaan aikaan. Jos epäonnistutte juotte molemmat 2 huikkaa. Kategoria: väri",
            "\(player1), ota 4 huikkaa tai poskiläimäisy pelaajalta \(player2)",
            "\(player1), sano 5 kertaa putkeen ”floridan broileri ja reilu litra maitoa” illan että kieli menee solmuun, tai juo 3 huikkaa",
            "\(player1), ota bodyshot pelaajalta \(player2)",
            "\(player1), demonstroi suosikki seksiasentosi pelaajan \(player2) kanssa",
            "\(player1), oudoin asia jota olet tehnyt seksin aikana?",
            "\(player1), haista pelaajan \(player2) kainaloa tai juo 2 huikkaa",
             "\(player1), onko sinulla fetissejä? Paljasta ne tai juo 4 huikkaa",
            "\(player1), soita exällesi tai juo 4 huikkaa",
            "\(player1), esitä känniläistä 15 sekuntia tai juo 2 huikkaa",
            "\(player1), näytä viimeisin lähettämäsi viesti tai juo 3 huikkaa",
            "\(player1), imitoi muiden pelaajien valitsemaa julkkista tai juo 3 huikkaa",
            "\(player1), soita tutullesi ja sano että rakastat häntä",
             "\(player1), mikä on mielestäsi rumin kehonosa vastakkaisessa sukupuolessa?",
            "\(player1), ota huikka ilman käsiä",
            "\(player1), näytä viimeisin kuva puhelimesi ”Kätketyt”-albumista",
            "\(player1), kerro vitsi. Jos muut pelaajat eivät naura, juo 2 huikkaa",
            "\(player1), anna pelaajalle \(player2) sylitanssi tai juo 4 huikkaa",
            "\(player1), anna pelaajan \(player2) laittaa sun someen jotain tai juo 4 huikkaa",
            "\(player1), juo raaka kananmuna tai ota 3 huikkaa",
            "\(player1), aina kun kiroilet, juo huikka loppupelin ajan",
            "\(player1), milloin viimeksi harrastit seksiä?",
            "\(player1), milloin viimeksi masturboit?",
            "\(player1), kuvaile viimeisintä katsomaasi aikuisviihdevideota",
            "\(player1), laula pelaajan \(player2) valitsemaa biisiä tai juo 3 huikkaa",
            "\(player1), näytä nänni tai juo 3 huikkaa",
            "\(player1), kerro salaisuus tai juo 3 huikkaa",
            "\(player1), oletko kiinnostunut kenestäkään",
            "\(player1), yritä saada pelaaja \(player2) nauramaan 30 sekunnin aikana. Jos epäonnistut, juo 3 huikkaa",
            "\(player1), ota paita pois loppupelin ajaksi tai juo 4 huikkaa",
            "\(player1), ota housut pois loppupelin ajaksi tai juo 4 huikkaa",
            "\(player1), twerkkaa 10 sekuntia tai juo 5 huikkaa",
            "\(player1), anna paras Mikki Hiiri -imitaatiosi",
            "\(player1), ota tuijotuskilpailu pelaajan \(player2) kanssa. Häviäjä juo 3 huikkaa",
            "\(player1), ota pelaaja \(player2) reppuselkään ja tee 3 kyykkyä, tai juo 5 huikkaa",
            "\(player1), vaihda vaatteita henkilön \(player2) kanssa tai juokaa molemmat 5 huikkaa",
            "\(player1), seuraavan 3 kierroksen ajan, saat puhua vain laulaen",
            "\(player1), seuraavan 3 kierroksen ajan, saat puhua vain suu kiinni. Jos epäonnistut, juo 3 huikkaa",
            "\(player1), tyynyjuttele tyynylle 30 sekunnin ajan tai juo 4 huikkaa",
            "\(player1), keksi jokaiselle pelaajalle uusi lempinimi",
             "\(player1), imitoi leijonaa 15 sekunnin ajan",
            "\(player1), juo lasi vettä yhdellä kulauksella",
            "\(player1), putkita mieto",
            "\(player1), näytä parhaimmat tanssiliikkeesi seuraavan 15 sekunnin ajan tai juo 5 huikkaa",
            "\(player1), näytä seksikkäin ilme minkä osaat tehdä",
            "\(player1), anna pelaajan \(player2) laittaa itsellesi huulipunaa loppupelin ajaksi",
            "\(player1), kerro nolo muisto",
            "\(player1), imitoi orgasmia 10 sekunnin ajan tai juo 5 huikkaa",
            "\(player1), ole loppupeli silmät sidottuna",
            "\(player1), freestyle räppää aiheesta: ”Olen rakastunut pelaajaan \(player2)”",
            "\(player1), puhu pelaajalle \(player2) kuin vauvalle",
            "\(player1), soita vanhemmillesi ja kerro olevasi raskaana, tai juo 5 huikkaa",
            "\(player1), lähetä tuhmin mahdollinen tekstiviesti pelaajalle \(player2) vain emojeita käyttäen",
           "Ottakaa ryhmäkuva",
            "Ottakaa ryhmäkuva mahdollisimman rumilla ilmeillä",
            "\(player1), anna pelaajan \(player2) laittaa viestiä puhelimellasi valitsemalleen henkilölle",
            "\(player1), nimeä 10 sekunnissa 5 maata jotka alkavat kirjaimella S tai juo 3 huikkaa",
            "\(player1), nimeä 10 disney-prinsessaa 15 sekunnissa tai juo 3 huikkaa",
            "\(player1), riisu pelaajan \(player2) sukat hampaillasi tai juo 4 huikkaa",
            "\(player1), mene ulos ja ulvo suden lailla tai juo 5 huikkaa",
            "\(player1), anna pelaajan \(player2) stailata hiuksesi loppu pelin ajaksi, tai juon4 huikkaa",
            "\(player1), aina kun juot, voihki jokaisen hörpyn jälkeen loppupelin ajan",
             "\(player1), esitä apinaa 10 sekunnin ajan tai juo 5 huikkaa",
            "\(player1), haista pelaajan \(player2) kainaloa tai juo 4 huikkaa",
            "\(player1), haista jokaisen pelaajan jalkoja ja kerro kenellä on pahin haju, tai juo 6 huikkaa",
            "\(player1), arvaa minkä väriset alushousut pelaajall \(player2) on. Jos arvaat oikein, hän juo 3 huikkaa. Jos väärin, juo itse 3",
            "\(player1), soita ilmakitaraa 15 sekunnin ajan eläytyen tai juo 4 huikkaa",
            "\(player1), esitä robottia seuraavan 3 kierroksen ajan tai juo 6 huikkaa",
            "\(player1), imitoi pelaajista valitsemaasi henkilöä niin pitkään, että joku arvaa ketä imitoit",
            "\(player1), tee 10 kyykkyä samalla kun \(player2) makaa selällään allasi",
            "\(player1), murise seksikkäästi tai juon5 huikkaa"
        ]
        
    }
    
    func newtask(p1: String, p2: String) -> String {
         guard let task = tasks.randomElement() else {
             return "Moe"
         }
         return task
     }
    
}

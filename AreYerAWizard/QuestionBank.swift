//
//  QuestionBank.swift
//  AreYerAWizard
//
//  Created by Alex Greene on 6/19/16.
//  Copyright © 2016 AlexGreene. All rights reserved.
//

import Foundation

class QuestionBank {
    
    internal static let questionBank = QuestionBank()
    
    fileprivate var bank: [Question] = []
    fileprivate var cursor: Int = 0
    fileprivate var correct: Int = 0
    
    init() {
        bank.append(Question(text: "Which ingredient is not needed to brew the Polyjuice Potion?", correct: "Billywig Sting", a: "Knotgrass", b: "Leeches", c: "Lacewing Flies"))
        
        bank.append(Question(text: "Who is the seeker for the Irish National Team in the Quidditch World Cup?", correct: "Lynch", a: "Mullet", b: "Troy", c: "Moran"))
        
        bank.append(Question(text: "How many points are awarded for scoring the Quaffle?", correct: "10", a: "15", b: "5", c: "7"))
        
        bank.append(Question(text: "The Sorting Hat has taken longer than 5 minutes to decide the house of which character?", correct: "Minerva Mcgonagall", a: "Neville Longbottom", b: "Hermione Granger", c: "Seamus Finnigan"))
        
        bank.append(Question(text: "Which broomstick does Harry use immediately after the Whomping Willow destroys his Nimbus 2000?", correct: "Shooting Star", a: "Cleansweep Seven", b: "Firebolt", c: "Nimbus 2001"))
        
        bank.append(Question(text: "How many Chocolate Frog cards did Ron say he had when he first met Harry?", correct: "~500", a: "174", b: "~200", c: "492"))
        
        bank.append(Question(text: "Which house did the Fat Friar belong to?", correct: "Hufflepuff", a: "Gryffindor", b: "Ravenclaw", c: "Slytherin"))
        
        bank.append(Question(text: "Who is the quickest to complete the 2nd Triwizard Task?", correct: "Cedric Diggory", a: "Victor Krum", b: "Harry Potter", c: "Fleur Delacour"))
        
        bank.append(Question(text: "What is Hermione Granger's patronus?", correct: "Otter", a: "Cat", b: "Owl", c: "Elephant"))
        
        bank.append(Question(text: "What is Ron Weasley's patronus?", correct: "Jack Russel Terrier", a: "Fox", b: "Weasel", c: "Border Collie"))
        
        bank.append(Question(text: "What is Severus Snape's patronus?", correct: "Doe", a: "Serpent", b: "Fox", c: "Bat"))
        
        bank.append(Question(text: "What is Aberforth Dumbledore's patronus?", correct: "Goat", a: "Buffalo", b: "Cow", c: "Horse"))
        
        bank.append(Question(text: "What is Ginny Weasley's patronus?", correct: "Horse", a: "Unicorn", b: "Rhino", c: "Moose"))
        
        bank.append(Question(text: "Which dragon is not brought to Hogwarts for the 1st Trwizard Task?", correct: "Ukranian Ironbelly", a: "Swedish Short-Snout", b: "Chinese Fireball", c: "Common Welsh Green"))
        
        bank.append(Question(text: "Which is not an original Weasley Wizarding Wheezes product?", correct: "Fanged Frisbee", a: "Boxing Telescope", b: "Puking Pastille", c: "Anti Gravity Hat"))
        
        bank.append(Question(text: "Which character is mentioned less than 1000 times throughout the HP series?", correct: "Minerva McGonagall", a: "Draco Malfoy", b: "Severus Snape", c: "Albus Dumbledore"))
        
        bank.append(Question(text: "Which character is mentioned the least throughout the HP series?", correct: "Professor Quirrell", a: "Hedwig", b: "Buckbeak", c: "Winky"))
        
        bank.append(Question(text: "How many times does the trio visit the Hogwarts kitchens during their 4th year?", correct: "2", a: "3", b: "1", c: "5"))
        
        bank.append(Question(text: "Who sends Ron a letter advising him to stay away from Harry Potter?", correct: "Percy Weasley", a: "Madame Bones", b: "Rita Skeeter", c: "Hannah Abbott"))
        
        bank.append(Question(text: "How does one enter the Hogwarts kitchens?", correct: "Tickle the pear", a: "Tickle the melon", b: "Sing the Hogwarts song", c: "Ask Professor Dumbledore"))
        
        bank.append(Question(text: "What species of snake does Harry speak to on Dudley's birthday?", correct: "Boa Constrictor", a: "Burmese Python", b: "Basilisk", c: "Corn Snake"))
        
        bank.append(Question(text: "S.P.E.W. stands for?", correct: "Society for the Promotion of Elvish Welfare", a: "Society for the Prevention of Elvish Warfare", b: "Society for the Protection of Elvish Welfare", c: "Singing Porcupines for English Wellbeing"))
        
        bank.append(Question(text: "Which character is not related to the rest?", correct: "Harry Potter", a: "Sirius Black", b: "Arthur Weasley", c: "Draco Malfoy"))
        
        ////////
    }
    
    func getNextQuestion() -> Question {
        if cursor >= bank.count - 1 {
            reset()
        }
        else {
            cursor += 1
        }
        
        QuestionBank.questionBank.saveStatus()

        let q = bank[cursor]
        return q
    }
    
    func getCurrentQuestion() -> Question {
        return bank[cursor]
    }
    
    func getJourneyCompletion() -> Int {
        return Int((Double(cursor) / Double(bank.count)) * 100)
    }
    
    func getAccuracy(_ flag: Int = 0) -> Int {
        if cursor == 0 {
            return -1
        }
        if flag == 1 {
            return Int((Double(correct)-1 / Double(cursor)) * 100)
        }
        return Int((Double(correct) / Double(cursor)) * 100)
    }
    
    func getRanking() -> String {
        let a = getAccuracy()
        let c = getJourneyCompletion()
        
        if c < 5 {
            return "FIRST YEAR"
        }
        else if ( a == 100 ) {
            return "GRAND WARLOCK"
        }
        else if ( a >= 99 ) {
            return "HEADMASTER"
        }
        else if ( a >= 98 ) {
            return "AUROR"
        }
        else if ( a >= 97 ) {
            return "SEVENTH YEAR"
        }
        else if ( a >= 96 ) {
            return "SIXTH YEAR"
        }
        else if ( a >= 95 ) {
            return "FIFTH YEAR"
        }
        else if ( a >= 93 ) {
            return "FOURTH YEAR"
        }
        else if ( a >= 91 ) {
            return "THIRD YEAR"
        }
        else if ( a >= 87 ) {
            return "SECOND YEAR"
        }
        else if ( a >= 85 ) {
            return "TROLL"
        }
        else if ( a >= 80 ) {
            return "FLOBBERWORM"
        }
        else if ( a < 80 ) {
            return "TROLL"
        }
        
        return "UNSPEAKABLE"
    }
    
    func submitAnswerForCurrentQuestion(_ answer: String!) -> Bool {
        if getCurrentQuestion().correct == answer {
            correct += 1
            QuestionBank.questionBank.saveStatus()
            return true
        }
        return false
    }
    
    func reset() {
        cursor = 0
        correct = 0
        
        QuestionBank.questionBank.saveStatus()
    }
    
    func saveStatus() {
        let defaults = UserDefaults.standard
        defaults.set(cursor, forKey: "_cursor")
        defaults.set(correct, forKey: "_correct")
        defaults.synchronize()
    }
    
    func loadStatus() {
        
        let defaults = UserDefaults.standard
        let x = defaults.string(forKey: "_cursor")
        let x2 = defaults.string(forKey: "_correct")
        
        if (x != "") {
          cursor = Int(x!)!
        }
        
        if (x2 != "") {
            correct = Int(x2!)!
        }
    }
    
    func shouldLoadIntroController() -> Bool {
        if cursor > 0 {
            return false
        }
        return true
    }
    
    func hasBeenCompleted() -> Bool {
        
        if cursor == bank.count - 1 {
            return true
        }
        
        return false
    }
    
}

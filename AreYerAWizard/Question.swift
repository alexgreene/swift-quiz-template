//
//  Question.swift
//  AreYerAWizard
//
//  Created by Alex Greene on 6/19/16.
//  Copyright © 2016 AlexGreene. All rights reserved.
//

import Foundation

class Question {
    
    var text: String!
    var correct: String!
    var a: String!
    var b: String!
    var c: String!
    
    init(text: String!, correct: String!, a: String!, b: String!, c: String!) {
        self.text = text
        self.correct = correct
        self.a = a
        self.b = b
        self.c = c
    }
}
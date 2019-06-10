//
//  Card.swift
//  Concentration
//
//  Created by Harsha on 07/06/19.
//  Copyright © 2019 Ixigo. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp=false
    var isMatched=false
    var Identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory+=1
        return identifierFactory;
    }
    
    init(){
        self.Identifier = Card.getUniqueIdentifier()
    }
    
}




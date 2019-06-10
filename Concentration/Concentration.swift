//
//  Concentration.swift
//  Concentration
//
//  Created by Harsha on 07/06/19.
//  Copyright © 2019 Ixigo. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUp: Int?
    
    func chooseCard(at index: Int) {
        //cards[index].isFaceUp = !cards[index].isFaceUp
        //including matchUp cases as well
        
        //only one card faceUp
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUp, matchIndex != index {
                if cards[matchIndex].Identifier == cards[index].Identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUp = nil
            } else {
                //when two or zero cards are faceUP
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUp = index
            }
        }
            
    }
    
    init(numberOfPairsOfCards: Int){
        var tempcards = [Card]()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            tempcards += [card,card]
        }
        //shuffle the cards
        var remainingCard = 0
        for _ in 1...2*numberOfPairsOfCards {
            let randomIndex = Int(arc4random_uniform(UInt32(2*numberOfPairsOfCards-remainingCard)))
            cards += [tempcards[randomIndex]]
            tempcards.remove(at: randomIndex)
            remainingCard = remainingCard+1
        }
        
    }
}


//
//  Concentration.swift
//  Concentration
//
//  Created by Harsha on 07/06/19.
//  Copyright © 2019 Ixigo. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()

    private(set) var score = 0
    
    private var indexOfOneAndOnlyFaceUp: Int?
    
    func chooseCard(at index: Int) {
        //cards[index].isFaceUp = !cards[index].isFaceUp
        //including matchUp cases as well
        
        //only one card faceUp
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUp, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[matchIndex].isSeen ==  true {
                        score -= 1
                    }
                }
                cards[matchIndex].isSeen = true
                cards[index].isSeen = true
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
    
    func reset() {
        for index in cards.indices {
            cards[index].isSeen = false
        }
        score = 0
    }
    
    init(numberOfPairsOfCards: Int) {
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


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
    
    let date = Date()
    private lazy var lastTimeTouched = date.timeIntervalSinceNow
    
    func chooseCard(at index: Int) {
        //cards[index].isFaceUp = !cards[index].isFaceUp
        //including matchUp cases as well
        
        //only one card faceUp
        
        let curTime = date.timeIntervalSinceNow
        let dateDiff = Int(curTime - lastTimeTouched)
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUp, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score = score + 2 + dateDiff
                } else {
                    if cards[matchIndex].isSeen {
                        score = score - 1 + dateDiff
                    }
                    if cards[index].isSeen {
                        score = score - 1 + dateDiff
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
        lastTimeTouched = curTime
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
        for _ in 1...2 * numberOfPairsOfCards {
            let randomIndex = Int(arc4random_uniform(UInt32(2 * numberOfPairsOfCards - remainingCard)))
            cards += [tempcards[randomIndex]]
            tempcards.remove(at: randomIndex)
            remainingCard = remainingCard + 1
        }
    }
}


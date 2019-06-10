//
//  ViewController.swift
//  Concentration
//
//  Created by Harsha on 06/06/19.
//  Copyright © 2019 Ixigo. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
    
    var flipCount = 0 {
        didSet /* everytime property i.e. flipCount here changes, insisde didSet is executed*/{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBOutlet weak var gameControlTitle: UIButton!
    
    @IBAction func gameControl(_ sender: UIButton) {
        let title = gameControlTitle.title(for: UIControl.State.normal)!
        if title == "Start" {
            gameControlTitle.setTitle("Stop", for: UIControl.State.normal)
            assignEmojiToCards()
            
        }else {
            gameControlTitle.setTitle("Start", for: UIControl.State.normal)
            for index in cardButtons.indices {
                let button = cardButtons[index]
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount+=1
        if let cardNumber = cardButtons.firstIndex(of: sender), gameControlTitle.title(for: UIControl.State.normal) == "Stop" /* unwraps optional value and if set then 'if' is executed otherwsie 'else' will be executed*/{
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } /*else {
            print("chosen card was not in cardbuttons")
        }*/
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🎃","👻","🍫","🍻","🎲","🎁","🧸","🖤","🇮🇳"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        
        //used in case of "optional datatype" so if it's set it's unwrapped and returned or else different value is returned in this case "?"
        return emoji[card.Identifier] ?? "?"
    }
    
    func assignEmojiToCards() {
        for index in cardButtons.indices {
            let card = game.cards[index]
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.Identifier]=emojiChoices[randomIndex]
        }
    }
}


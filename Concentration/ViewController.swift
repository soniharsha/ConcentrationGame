//
//  ViewController.swift
//  Concentration
//
//  Created by Harsha on 06/06/19.
//  Copyright © 2019 Ixigo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //TODO: INCORPORATED
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    // MARK: Outlets
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var gameControlTitle: UIButton!
    
    // Actions
    
    @IBAction func gameControl(_ sender: UIButton) {
        let title = gameControlTitle.title(for: UIControl.State.normal)!
        if title == "Start" {
            flipCountLabel.text = "SCORE: \(game.score)"
            gameControlTitle.setTitle("Stop", for: UIControl.State.normal)
            assignEmojiToCards()
            for index in cardButtons.indices {
                cardButtons[index].backgroundColor = buttonFlipColor
            }
            flipCountLabel.textColor = UIColor.white
            flipCountLabel.backgroundColor = buttonFlipColor
            gameControlTitle.backgroundColor = buttonFlipColor
            gameControlTitle.setTitleColor(UIColor.white, for: UIControl.State.normal)
        } else {
            gameControlTitle.setTitle("Start", for: UIControl.State.normal)
            for index in cardButtons.indices { // use forEach
                let button = cardButtons[index]
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = .orange
                flipCountLabel.textColor = UIColor.orange
                flipCountLabel.backgroundColor = UIColor.white.withAlphaComponent(0.0)
                self.view.backgroundColor = UIColor.black
                emoji[game.cards[index].identifier] = nil
                game.reset()
            }
            gameControlTitle.backgroundColor = .red
            gameControlTitle.setTitleColor(UIColor.black, for: UIControl.State.normal)
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender), gameControlTitle.title(for: UIControl.State.normal) == "Stop" /* unwraps optional value and if set then 'if' is executed otherwsie 'else' will be executed*/{
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    // Make things private
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.white.withAlphaComponent(0.0) : buttonFlipColor
            }
        }
        
        flipCountLabel.text = "SCORE: \(game.score)"
    }
    
    
    private var emoji = [Int:String]()
    var buttonFlipColor = UIColor.orange
    
    private func emoji(for card: Card) -> String? {
        //used in case of "optional datatype" so if it's set it's unwrapped and returned or else different value is returned in this case "?"
        return emoji[card.identifier]
    }
    
    private func assignEmojiToCards() {
        var emojiChoices = [0: ["🤣","😍","🤫","🤮","🤦🏻‍♀️","🤷🏻‍♀️","🥺","🙆🏻‍♀️"],
                            1: ["🙈","🙉","🙊","🐵","🐒","🐻","🐨","🐶"],
                            2: ["🍐","🍏","🍈","🍌","🥝","🍋","🍇","🍍"],
                            3: ["❤️","🧡","💛","💚","💙","💜","💖","🖤"]]
        
        var viewBackgroundColors = [UIColor.yellow, UIColor.brown, UIColor.green, UIColor.red ]
        var buttonBackgroundColors = [UIColor.magenta, UIColor.darkGray, UIColor.brown, UIColor.black]
        
        var uniqueEmojiIndex = 0
        let totalUniqueEmojiIndex = (cardButtons.count + 1) / 2
        let randomKey = Int(arc4random_uniform(UInt32(emojiChoices.count)))
        self.view.backgroundColor = viewBackgroundColors[randomKey]
        buttonFlipColor = buttonBackgroundColors[randomKey]
        
        for index in cardButtons.indices {
            let card = game.cards[index]
            
            if emoji[card.identifier] == nil {
                let randomEmojiIndex = Int(arc4random_uniform(UInt32(totalUniqueEmojiIndex-uniqueEmojiIndex)))
                
                emoji[card.identifier] = emojiChoices[randomKey]![randomEmojiIndex]
                emojiChoices[randomKey]!.remove(at: randomEmojiIndex)
                uniqueEmojiIndex = uniqueEmojiIndex + 1
            }
        }
    }
}


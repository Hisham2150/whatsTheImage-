//
//  Game.swift
//  whatsTheImage!
//
//  Created by Hisham Bajunaid on 2018-08-05.
//  Copyright © 2018 Hisham Bajunaid. All rights reserved.
//

import Foundation

struct Game{
    
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character] //array of characters that stores the letters that are pressed
    
    mutating func playerGuessedLetters(letter: Character){
        guessedLetters.append(letter) // appends the letters guessed to an array of characters to keep track of the letters that have been pressed
        if !word.contains(letter){ //Checks if the letter is not contained within the word, if so incorrectMovesRemaining is incremented by -1 and remaining guesses goes down
            incorrectMovesRemaining -= 1
            
        }
        
    }
    var formattedWords: String {
        var guessedWord = ""
        for letter in word{
            if guessedLetters.contains(letter){
              guessedWord += "\(letter)"
            }else{
              guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    
}


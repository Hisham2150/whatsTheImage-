//
//  ViewController.swift
//  whatsTheImage!
//
//  Created by Hisham Bajunaid on 2018-08-05.
//  Copyright © 2018 Hisham Bajunaid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var listOfPictureNames = ["car","truck","bicycle"]//,"apple","orange","banana","dog","cat","fox","airplane","table","panda","tiger","blueberry","phone","laptop","tree","spoon","cup","eyes","fork","lemon","nose","heart","brain"]
    
    let incorrectMovesAllowed = 5
    
    var wordsGuessedCorrect = 0 {
        didSet {
            newRound()
        }
    }
    var wordsGuessedIncorrect = 0 {
        didSet{
            newRound()
        }
    }
    
    
    @IBOutlet weak var picturesImageView: UIImageView!
    
    @IBOutlet weak var imageName: UILabel!
    
    @IBOutlet weak var winsLossesLabel: UILabel!
    
    @IBOutlet var buttonLetters: [UIButton]!
    
    @IBOutlet weak var triesRemaining: UILabel!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false // disables a button when it is pressed so it cann't be pressed again
        let letterString = sender.title(for: .normal)! // setting letterString = to the title of the button titles. The ! mark tells swift that all the buttons have titles
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessedLetters(letter: letter) // passing letter in to the func playerGuessedLetters to see if the letter pressed is contained in the word or not
        updateGameState()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        updateUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
     var currentGame: Game! // The ! lets the compiler know that currentGame is allowed to not have a value. This is okay because each time a new round starts currentGame does not have a value
    
    
    func newRound(){
        if !listOfPictureNames.isEmpty{
        let newWord = listOfPictureNames.removeFirst() // newWord becomes the next item in the listOfPictureNames
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: []) // making currentGame an instance of Game where newWord is being passed in for the var word & incorrectMovesAllowed is passed in to incorrectMoviesRemaining. This updates the game with a new word and resets the amount of mistakes that are allowed
        enableLetterButtons(true)
        updateUI()
            
        }else{
            enableLetterButtons(false)
           let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "lastScene")
            self.present(nextViewController, animated:true, completion:nil)

        }
        
    }
    
    func enableLetterButtons(_ enable: Bool){
        for button in buttonLetters{
            button.isEnabled = enable
        }
        
    }
    
    func updateGameState(){
            if currentGame.word == currentGame.formattedWords {
                wordsGuessedCorrect += 1
            }else if currentGame.incorrectMovesRemaining == 0{
                wordsGuessedIncorrect += 1
            }else{
                updateUI()
            }
        }
        
    

    func updateUI(){
        //update picture
        picturesImageView.image = UIImage(named: "Picture \(currentGame.word)")//updates the image when a new word appears
        //update score
        winsLossesLabel.text = "Words Guessed Correct: \(wordsGuessedCorrect), Words Guessed Incorrect: \(wordsGuessedIncorrect)" //updates the score with totalWins and TotalLosses
        //upate tries remaining
        triesRemaining.text = "Guesses Remaining: \(currentGame.incorrectMovesRemaining)"
        // update imageName
        imageName.text = currentGame.formattedWords
        var letters = [String]()
        for letter in currentGame.formattedWords{
            letters.append(String(letter)) //
        }
        let wordWithSpacing = letters.joined(separator: " ")
        imageName.text = wordWithSpacing
        
        
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


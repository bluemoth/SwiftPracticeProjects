//
//  ViewController.swift
//  MilestoneProject7_9_Hangman
//
//  Created by Jacob Case on 1/29/22.
//

import UIKit

class ViewController: UIViewController {
    
    var gameArt: UILabel!
    var chosenLetter: UITextField!
    var usedLetters: UILabel!
    var wordToGuess: UILabel!
    let hangManArt = ["""
      +---+
      |   |
          |
          |
          |
          |
    =========
    """, """
      +-----+
      |     |
      O     |
            |
            |
            |
    =========
    """, """
      +-----+
      |     |
      O     |
      |     |
            |
            |
    =========
    """, """
      +-----+
      |     |
      O     |
     /|     |
            |
            |
    =========
    """, """
      +-----+
      |     |
      O     |
     /|\\   |
            |
            |
    =========
    ""","""
      +-----+
      |     |
      O     |
     /|\\   |
     /      |
            |
    =========
    ""","""
      +-----+
      |     |
      O     |
     /|\\   |
     / \\   |
            |
    =========
    """]
    
    
    
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = .white
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("Submit", for: .normal)
        view.addSubview(submit)

        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("Clear", for: .normal)
        view.addSubview(clear)
        
        gameArt = UILabel()
        gameArt.translatesAutoresizingMaskIntoConstraints = false
        gameArt.font = UIFont.systemFont(ofSize: 32)
        gameArt.numberOfLines = 0
        gameArt.textAlignment = .center
        gameArt.layer.borderWidth = 1
        view.addSubview(gameArt)
        
        wordToGuess = UILabel()
        wordToGuess.translatesAutoresizingMaskIntoConstraints = false
        wordToGuess.text = ""
        wordToGuess.font = UIFont.systemFont(ofSize: 32)
        wordToGuess.textAlignment = .center
        view.addSubview(wordToGuess)
        
        chosenLetter = UITextField()
        chosenLetter.translatesAutoresizingMaskIntoConstraints = false
        chosenLetter.placeholder = "Enter a letter"
        chosenLetter.textAlignment = .center
        chosenLetter.font = UIFont.systemFont(ofSize: 30)
        chosenLetter.isUserInteractionEnabled = true
        view.addSubview(chosenLetter)
        
        usedLetters = UILabel()
        usedLetters.translatesAutoresizingMaskIntoConstraints = false
        usedLetters.text = "Used letters will show up here..."
        usedLetters.textAlignment = .left
        usedLetters.font = UIFont.systemFont(ofSize: 25)
        usedLetters.isUserInteractionEnabled = false
        view.addSubview(usedLetters)
        
        NSLayoutConstraint.activate([
            gameArt.heightAnchor.constraint(equalToConstant: 300),
            gameArt.widthAnchor.constraint(equalToConstant: 300),
            gameArt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameArt.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
            
            wordToGuess.topAnchor.constraint(equalTo: gameArt.bottomAnchor),
            wordToGuess.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordToGuess.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            chosenLetter.topAnchor.constraint(equalTo: wordToGuess.bottomAnchor),
            chosenLetter.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            chosenLetter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            submit.topAnchor.constraint(equalTo: chosenLetter.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 35),
            
            clear.topAnchor.constraint(equalTo: chosenLetter.bottomAnchor),
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.heightAnchor.constraint(equalToConstant: 35),
            
            usedLetters.topAnchor.constraint(equalTo: clear.bottomAnchor),
            usedLetters.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usedLetters.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        beginGame()
    }
    
    func beginGame() {
        gameArt.text = hangManArt[0]
        wordToGuess.text = getRandomWord()
        
    }
    
    func getRandomWord() -> String {
        return maskWord(word: "text")
        
    }
    
    func maskWord(word: String) -> String {
        var maskedWord: String = ""
        for _ in word {
            maskedWord += "?"
        }
        return maskedWord
    }


}

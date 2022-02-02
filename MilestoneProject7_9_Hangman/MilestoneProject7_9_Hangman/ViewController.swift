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
    var letterButtons = [UIButton]()
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
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
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
            
            buttonsView.widthAnchor.constraint(equalToConstant: 200),
            buttonsView.heightAnchor.constraint(equalToConstant: 200),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
            
        ])
        
        // set some values for the width and height of each button
        let width = 15
        let height = 15

        // create 26 buttons as a 2x13 grid
        for row in 0..<2 {
            for col in 0..<13 {
                // create a new button and give it a big font size
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)

                // give the button some temporary text so we can see it on-screen
                letterButton.setTitle("?", for: .normal)

                // calculate the frame of this button using its column and row
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame

                // add it to the buttons view
                buttonsView.addSubview(letterButton)

                // and also to our letterButtons array
                letterButtons.append(letterButton)
            }
        }
        
//        buttonsView.backgroundColor = .gray
//        submit.backgroundColor = .red
//        clear.backgroundColor = .blue
//        gameArt.backgroundColor = .brown
//        wordToGuess.backgroundColor = .cyan
//        chosenLetter.backgroundColor = .systemPink
        
        }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        beginGame()
    }
    
    func beginGame() {
        gameArt.text = hangManArt[5]
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

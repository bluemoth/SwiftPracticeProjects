//
//  ViewController.swift
//  MilestoneProject7_9_Hangman
//
//  Created by Jacob Case on 1/29/22.
//

import UIKit

class ViewController: UIViewController {
    
    var gameArt: UILabel!
    var gameTitle: UILabel!
    var chosenLetter: UITextField!
    var usedLetters = [Character]()
    var wrongAnswers: Int = 0 {
        didSet {
            gameArt.text = hangManArt[wrongAnswers]
        }
    }
    var wordToGuess: String = ""
    var wordToGuessLabel: UILabel!
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    
    var maskedWord: String = ""
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
        
        //MARK: - Asset Definitions
        view = UIView()
        view.backgroundColor = .white
        
        gameTitle = UILabel()
        gameTitle.translatesAutoresizingMaskIntoConstraints = false
        gameTitle.font = UIFont.systemFont(ofSize: 32)
        gameTitle.textColor = .black
        gameTitle.numberOfLines = 0
        gameTitle.textAlignment = .center
        view.addSubview(gameTitle)
        
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("Submit", for: .normal)
        view.addSubview(submit)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)


        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("Clear", for: .normal)
        view.addSubview(clear)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)

        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        gameArt = UILabel()
        gameArt.translatesAutoresizingMaskIntoConstraints = false
        gameArt.font = UIFont.systemFont(ofSize: 28)
        gameArt.textColor = .black
        gameArt.numberOfLines = 0
        gameArt.textAlignment = .center
        gameArt.layer.borderWidth = 1
        view.addSubview(gameArt)
        
        wordToGuessLabel = UILabel()
        wordToGuessLabel.translatesAutoresizingMaskIntoConstraints = false
        wordToGuessLabel.text = ""
        wordToGuessLabel.textColor = .black
        wordToGuessLabel.font = UIFont.systemFont(ofSize: 32)
        wordToGuessLabel.textAlignment = .center
        view.addSubview(wordToGuessLabel)
        
        let myTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        myTextField.backgroundColor = .blue
        myTextField.attributedPlaceholder = NSAttributedString(
            string: "Placeholder Text",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        
        
        chosenLetter = UITextField()
        chosenLetter.translatesAutoresizingMaskIntoConstraints = false
        //chosenLetter.placeholder = "Select a letter"
        chosenLetter.attributedPlaceholder = NSAttributedString(string: "Select a letter", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        chosenLetter.textColor = .black
        chosenLetter.textAlignment = .center
        chosenLetter.font = UIFont.systemFont(ofSize: 30)
        chosenLetter.isUserInteractionEnabled = false
        view.addSubview(chosenLetter)
        
        
        //MARK: - UI Layout with Assets
        NSLayoutConstraint.activate([
            
            gameTitle.heightAnchor.constraint(equalToConstant: 200),
            gameTitle.widthAnchor.constraint(equalToConstant: 300),
            gameTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -350),
            
            //gameArt.heightAnchor.constraint(equalToConstant: 300),
            gameArt.widthAnchor.constraint(equalToConstant: 300),
            gameArt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameArt.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            
            wordToGuessLabel.topAnchor.constraint(equalTo: gameArt.bottomAnchor),
            wordToGuessLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordToGuessLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            
            chosenLetter.topAnchor.constraint(equalTo: wordToGuessLabel.bottomAnchor),
            chosenLetter.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            chosenLetter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            submit.topAnchor.constraint(equalTo: chosenLetter.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 35),
            
            clear.topAnchor.constraint(equalTo: chosenLetter.bottomAnchor),
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.heightAnchor.constraint(equalToConstant: 35),
            
            buttonsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            buttonsView.heightAnchor.constraint(equalToConstant: 200),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0)
            
        ])
        
        // set some values for the width and height of each button
        let width = 30
        let height = 30

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
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            }
        }
//        Colors to enable outlines of UI
        buttonsView.backgroundColor = .gray
        submit.backgroundColor = .red
        clear.backgroundColor = .blue
        gameArt.backgroundColor = .brown
        //wordToGuess.backgroundColor = .cyan
        chosenLetter.backgroundColor = .systemPink
        
        }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(beginGame))
        
        beginGame()
    }
    
    //MARK: - Game Logic
    @objc func beginGame(action: UIAlertAction! = nil) {
        gameArt.text = hangManArt[0]
        gameTitle.text = "HangMan"
        usedLetters.removeAll()
        wrongAnswers = 0
        maskedWord = ""
        wordToGuessLabel.text = getRandomWord()

        for btn in activatedButtons {
            btn.isHidden = false
        }
        activatedButtons.removeAll()
        chosenLetter.text = ""
        
        if let letterFileURL = Bundle.main.url(forResource: "alphabet", withExtension: "txt") {
            if let letterContents = try? String(contentsOf: letterFileURL) {
                let letters = letterContents.components(separatedBy: "\n")
                
                // load letters into buttons group
                for (index, letter) in letters.enumerated() {
                    letterButtons[index].setTitle(letter, for: .normal)
                }
            }
        }
    }
    
    func gameOver(_ winLose: Bool) {
        if (winLose) {
            let ac = UIAlertController(title: "You win!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play again?", style: .default, handler: beginGame))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Game Over", message: "You lose! The word was \(wordToGuess).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play again?", style: .default, handler: beginGame))
            present(ac, animated: true)
        }
    }
    
    
    func getRandomWord() -> String {
        if let wordFileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let wordContents = try? String(contentsOf: wordFileURL) {
                let words = wordContents.components(separatedBy: "\n")
                wordToGuess = words.randomElement()!
            }
        }
        return maskWord(word: wordToGuess)
    }
    
    func maskWord(word: String) -> String {
        for _ in word {
            maskedWord += "?"
        }
        return maskedWord
    }
    
    func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
        var chars = Array(myString)     // gets an array of characters
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    
    
    
    //MARK: - Letter, Submit, Clear Button Actions
    @objc func clearTapped(_ sender: UIButton) {
        if chosenLetter.text == "" {
            return
        } else {
            activatedButtons.last?.isHidden = false
            chosenLetter.text = ""
        }
    }

    @objc func letterTapped(_ sender: UIButton) {
        if chosenLetter.text != "" {
            let ac = UIAlertController(title: "One letter already chosen!", message: "Submit or clear chosen letter.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK ", style: .default, handler: nil))
            present(ac, animated: true)
            return
        }
        guard let buttonTitle = sender.titleLabel?.text else { return }
        chosenLetter.text = chosenLetter.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let selectedLetter = chosenLetter.text else {return}
    
        if selectedLetter == "" {
            let ac = UIAlertController(title: "No letter selected", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
            return
        
        } else if wordToGuess.contains(selectedLetter) {
            usedLetters.append(Character(selectedLetter))
            for (index, letter) in wordToGuess.enumerated() {
                if String(letter) == selectedLetter {
                    maskedWord = replace(myString: maskedWord, index, Character(selectedLetter))
                }
            }
        } else {
            wrongAnswers += 1
            usedLetters.append(Character(selectedLetter))
            if wrongAnswers > 5 {
                gameOver(false)
            }
        }
        wordToGuessLabel.text = maskedWord
        if maskedWord == wordToGuess {
            gameOver(true)
        }
        chosenLetter.text = ""
        print(usedLetters)
    }
    
    
}

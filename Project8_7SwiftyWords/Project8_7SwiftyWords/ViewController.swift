//
//  ViewController.swift
//  Project8_7SwiftyWords
//
//  Created by Jacob Case on 1/26/22.
//

import UIKit

class ViewController: UIViewController {

    // define labels, current answer text field, and letter buttons
    // hints for the word
    var cluesLabel: UILabel!
    // answers label is really # characters in the answer...
    var answersLabel: UILabel!
    // user text field that fills when buttons tapped
    var currentAnswer: UITextField!

    var scoreLabel: UILabel!
    // array of buttons to hold leter groups, used in load level for matching to letter bits
    var letterButtons = [UIButton]()
    
    // ghost activated buttons and solutions
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        view.addSubview(cluesLabel)

        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.numberOfLines = 0
        answersLabel.textAlignment = .right
        view.addSubview(answersLabel)
        
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        // code generated button for submitting answer
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        view.addSubview(submit)
        // caller for submit button tap
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)

        // code generated button for clearing answer
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        view.addSubview(clear)
        // caller for cler button tap
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)

        // create a view placeholder for future array of buttons
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        
        NSLayoutConstraint.activate([
                scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0),
                // pin the top of the clues label to the bottom of the score label
                cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),

                // pin the leading edge of the clues label to the leading edge of our layout margins, adding 100 for some space
                cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),

                // make the clues label 60% of the width of our layout margins, minus 100
                cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),

                // also pin the top of the answers label to the bottom of the score label
                answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),

                // make the answers label stick to the trailing edge of our layout margins, minus 100
                answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),

                // make the answers label take up 40% of the available space, minus 100
                answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),

                // make the answers label match the height of the clues label
                answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
                
                //center current answer
                currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                //current answer to be 50% of width
                currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                
                //place below clues label + 20pts
                currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
                
                submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
                submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
                submit.heightAnchor.constraint(equalToConstant: 44),
                
                clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:100),
                clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
                clear.heightAnchor.constraint(equalToConstant: 44),
                
                buttonsView.heightAnchor.constraint(equalToConstant: 320),
                buttonsView.widthAnchor.constraint(equalToConstant: 750),
                buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
                buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
                
                //add more constraints
            ])
        
        // set some values for the width and height of each button
        let width = 150
        let height = 80

        // create 20 buttons as a 4x5 grid
        for row in 0..<4 {
            for col in 0..<5 {
                // create a new button and give it a big font size
                let letterButton = UIButton(type: .system)
                
                // Challenge #1; create borders around the letterButtons to make it stand out
                letterButton.layer.borderWidth = 1
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)

                // give the button some temporary text so we can see it on-screen
                letterButton.setTitle("WWW", for: .normal)

                // calculate the frame of this button using its column and row
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame

                // add it to the buttons view
                buttonsView.addSubview(letterButton)
                
                // Challenge #1; create borders around buttonView
                buttonsView.layer.borderColor = UIColor.gray.cgColor
                buttonsView.layer.borderWidth = 3
                buttonsView.layer.cornerRadius = 5
                    
                // and also to our letterButtons array
                letterButtons.append(letterButton)
                
                // caller for the letterbuttons function
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadLevel()

    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else {return}

        
        if let solutionsPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            
            splitAnswers?[solutionsPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score+=1
            
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's Go", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        } else {
            // Challenge #2 : If the user enters an incorrect guess, show an alert telling them they are wrong.
            // You’ll need to extend the submitTapped()
            // method so that if firstIndex(of:) failed to find the guess you show the alert.
            let ac = UIAlertController(title: "Incorrect answer!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Guess again...", style: .default, handler: nil))
            present(ac, animated: true)
        }
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""

        for btn in activatedButtons {
            btn.isHidden = false
        }

        activatedButtons.removeAll()
    }
    
    func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)

        loadLevel()

        for btn in letterButtons {
            btn.isHidden = false
        }
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        // Look in app bundle and fetch level text file
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            // within this operation, store contents of URL
            if let levelContents = try? String(contentsOf: levelFileURL) {
                // wthin this operation, perform separation on newline
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    //print(solutionWord)
                    solutionString += "\(solutionWord.count) letters\n"
                    //print(solutionString)
                    solutions.append(solutionWord)
                    //print(solutions)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                    //print(letterBits)
                    
                }
            }
        }
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

        letterBits.shuffle()

        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
}


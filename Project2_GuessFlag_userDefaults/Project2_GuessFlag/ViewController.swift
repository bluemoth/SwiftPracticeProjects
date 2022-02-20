//
//  ViewController.swift
//  Project2_GuessFlag
//
//  Created by Jacob Case on 1/15/22.
//

//Challenge
//One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on:
//
//Try showing the player’s score in the navigation bar, alongside the flag to guess. --done
//Keep track of how many questions have been asked --done, and show one final alert controller after they have answered 10. This should show their final score.
//When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.


import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var numberOfQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(loadScore())
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(showScore))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Highscore", style: .plain, target: self, action: #selector(grabScore))
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()

    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased() + ", Score = \(String(score))"
        numberOfQuestions += 1
        print(numberOfQuestions)
    }
    
    func resetGame(action: UIAlertAction! = nil) {
        numberOfQuestions = 0
        score = 0
        correctAnswer = 0
        askQuestion()
    }
    
    @objc func showScore() {
        let item = "Your score is \(String(score))"
        let vc = UIActivityViewController(activityItems: [item], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(vc, animated: true)
            
        
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        if numberOfQuestions == 10 {
            saveScore(score)
            let ac = UIAlertController(title: "Game Over", message: "Your Final Score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: resetGame))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        
    }

    func saveScore(_ score: Int) {
        let lastScore = loadScore()
        if lastScore < score {
            let ac = UIAlertController(title: "New high score of \(score)!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: resetGame))
            present(ac, animated: true)
            
            let defaults = UserDefaults.standard
            defaults.set(score, forKey: "score")
        }
    }
    
    func loadScore() -> Int {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: "score") as? Int ?? 0
    }
    
    @objc func grabScore() {
        if numberOfQuestions < 10 {
            return
        } else {
            let defaults = UserDefaults.standard
            print(defaults.object(forKey: "score") as? Int ?? 0)
        }
    }
    
}


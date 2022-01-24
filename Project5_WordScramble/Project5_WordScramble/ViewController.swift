//
//  ViewController.swift
//  Project5_WordScramble
//
//  Created by Jacob Case on 1/17/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
    var selectedWord: String = ""
    
    // add enum for challenge2; error states based on user submitted answers
    enum errorState {
        case isRealError
        case isPossibleError
        case isOriginalError
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }

        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        startGame()
    }
    
    func startGame() {
        selectedWord = allWords.randomElement()!
        title = selectedWord
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
        
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()

        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer.lowercased(), at: 0)

                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)

                    return
                } else {
                    showErrorMessage(.isRealError)
                }
            } else {
                showErrorMessage(.isOriginalError)
            }
        } else {
            showErrorMessage(.isPossibleError)
        }
    }
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }

        return true
    }

    func isOriginal(word: String) -> Bool {
        // Challenge 1; return false if word entered is same as word chosen from list
        if word.lowercased() == selectedWord.lowercased() {
            return false
        }
        return !usedWords.contains(word)
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        // Challenge 1; return false if length is less than 3
        if word.utf16.count < 3 {
            return false
        }
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    // Challenge 2; This should accept an error message and a title, and do all the UIAlertController work from there.
    func showErrorMessage(_ error: errorState) {
        var errorTitle: String = ""
        var errorMessage: String = ""
        
        if error == errorState.isRealError {
            print(error)
            errorTitle = "Word not recognised"
            errorMessage = "You can't just make them up, you know!"
        }
        
        if error == errorState.isOriginalError {
            print(error)
            errorTitle = "Word used already"
            errorMessage = "Be more original!"
        }
    
        if error == errorState.isPossibleError {
            print(error)
            guard let title = title?.lowercased() else { return }
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title)"
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
    }
    
    // Challenge 3; implement a left button at top of nav bar to reset game with new word
    @objc func resetGame() {
        startGame()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }


}


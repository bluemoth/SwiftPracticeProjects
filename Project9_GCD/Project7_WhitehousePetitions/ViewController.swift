//
//  ViewController.swift
//  Project7_WhitehousePetitions
//
//  Created by Jacob Case on 1/25/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    
    // part of challenge 2, duplicate copy of petitions for filtered results only
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Challenge 1: Add a Credits button to the top-right corner using UIBarButtonItem. When this is tapped, show an alert telling users the data comes from the We The People API of the Whitehouse.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        
        // Challenge 2:Let users filter the petitions they see. This involves creating a second array of filtered items that contains only petitions matching a string the user entered. Use a UIAlertController with a text field to let them enter that string.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(promptSearch))
        
        print("***ViewDidLoad function is on main thread: \(Thread.isMainThread)\n")
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
    }
    
    func parse(json: Data) {
        print("***Parse function is on main thread: \(Thread.isMainThread)\n")
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }

    @objc func showError() {
        print("***Show error function is on main thread: \(Thread.isMainThread)")
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func fetchJSON() {
        let urlString: String
        print("***FetchJSON function is on main thread: \(Thread.isMainThread)\n")

        if navigationController?.tabBarItem.tag == 0 {
            //urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            //urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }

        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    // Part of challenge 2; function that backs promptSearch method. Takes user input and extracts relevant petitions
    // does depend on casing for str
    func beginSearch(_ str: String) {
        DispatchQueue.global().async {
            print("***BeginSearch function is on main thread: \(Thread.isMainThread)\n")
            if str.isEmpty {
                return
            } else {
                self.filteredPetitions.removeAll(keepingCapacity: true)
                for singlePetition in self.petitions {
                    if singlePetition.title.contains(str) {
                        self.filteredPetitions.append(singlePetition)
                    }
                }
                DispatchQueue.main.async {
                    print("TableView Reload Else is on main thread: \(Thread.isMainThread)\n")
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // part of challenge 2, method for prompting user to enter a string to search on
    @objc func promptSearch() {
        let ac = UIAlertController(title: "Enter Search String", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitString = UIAlertAction(title: "Search", style: .default) { [weak self, weak ac] _ in
            guard let searchString = ac?.textFields?[0].text else {return}
            self?.beginSearch(searchString)
        }
        
        ac.addAction(submitString)
        present(ac, animated: true)
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Data comes from:", message: "We The People API", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // part of challenge 2 to update tableView to only include filtered results
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // update for challenge 2, only include filtered results
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        
        //updated for challenge 2
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}


//
//  ViewController.swift
//  Project1_StormViewer
//
//  Created by Jacob Case on 1/15/22.
//

import UIKit

class ViewController: UITableViewController {
    
    //var pictures = [String]()
    var pics = [Pictures]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        if let savedPics = defaults.object(forKey: "pics") as? Data {
            if let decodedPics = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPics) as? [Pictures] {
                pics = decodedPics
            }
            print("load from \(savedPics)")
        } else {
            performSelector(inBackground: #selector(loadImages), with: nil)
            print("performing load images function")
        }
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true

        print(Thread.isMainThread)
    }
    
    @objc func loadImages() {
        //BACKGROUND THREAD - Begin performing file loads from background thread
        // let fm = file manager default from system
        let fm = FileManager.default
        
        // A representation of the code and resources stored in a bundle directory on disk
        // path = that bundle
        let path = Bundle.main.resourcePath!
        
        // items array is constant collection of items found within file directory
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load
                print(item)
                //pictures.append(item)
                let pic = Pictures(picture: item, tapCount: 0)
                pics.append(pic)
            }
        }

        //MAIN THREAD - pictures loaded, call reload method on main
        DispatchQueue.main.sync {
            self.tableView.reloadData()
            print(Thread.isMainThread)
        }
        
        print(Thread.isMainThread)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pics.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let picCount = pics[indexPath.row].tapCount
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pics[indexPath.row].picture
        cell.textLabel?.font = UIFont(name: "Noteworthy", size: 20)
        cell.detailTextLabel?.text = "TapCount = \(picCount)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Challenge 1 for Project 12 - Modify project 1 so that it remembers how many times each storm image was shown
        
        let pic = pics[indexPath.row]
        pic.tapCount += 1
        print(pic.tapCount)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pics[indexPath.row].picture
            vc.pictureNumber = indexPath.row+1
            vc.numPictures = pics.count
            navigationController?.pushViewController(vc, animated: true)
        }
        self.save()
        tableView.reloadData()
    }
    
    func save() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: pics, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "pics")
            print("saved OK \(savedData)")
        }
    }
}


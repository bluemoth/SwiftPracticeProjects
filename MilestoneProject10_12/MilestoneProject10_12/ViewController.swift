//
//  ViewController.swift
//  MilestoneProject10_12
//
//  Created by Jacob Case on 2/21/22.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var tableView: UITableView!
    
    var meals = [Meal]()
    var protein = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "MealCell", bundle: nil), forCellReuseIdentifier: "MealCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,target: self, action: #selector(addMeal))
    }
    
    @objc func takePicture() {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
        } else {
            let ac = UIAlertController(title: "No Camera Available", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        }
        
    }
    
    @objc func addMeal() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        1.) Extract the image from the dictionary that is passed as a parameter. info[.editedImage]
//        2.) Generate a unique filename for it. UUID().uuidString
//        3.) Convert it to a JPEG, then write that JPEG to disk.
//        4.) Dismiss the view controller.
        
        guard let image = info[.editedImage] as? UIImage else {return}
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let meal = Meal(name: "Empty", date: "", image: imageName)
        meals.append(meal)
        tableView.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as? MealCell else {
            fatalError("Unable to deque, issue with cell")
        }
        let date = Date()
        let currentDate = date.formatted(date: .abbreviated, time: .omitted)
        let meal = meals[indexPath.row]
        
        cell.name.text = meal.name
        cell.date.text = currentDate
        
        let path = getDocumentsDirectory().appendingPathComponent(meal.image)
        cell.mealImage.image = UIImage(contentsOfFile: path.path)
        cell.mealImage.layer.cornerRadius = 5
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(protein)
    }
}

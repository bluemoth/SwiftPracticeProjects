//
//  ViewController.swift
//  Project10_NamesToFaces
//
//  Created by Jacob Case on 2/8/22.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // instantiate an array of person class
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // add button on left to allow user to select an image within directory
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
    }
    // function call for adder button. ViewController set as the delegate
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // cell to be "Person" and fall through if valid
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue PersonCell")
        }
        
        // item at this indexPath was created by didFinishPickingMedia
        // cell for item populates based on person array defined at top
        let person = people[indexPath.item]
        cell.name.text = person.name
        
        // path is a url path to user documents
        // grab the edited copy of the image from this dir and populate cell with it
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        // print(person.image) ---> This is the UUID at path
        // image within cell is now selected at the given path
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Below are steps to selecting an image, and using it within a collection
        // 1.) select the image
        // 2.) name image using UUID
        // 3.) set path for image storage
        // 4.) write path of image with UUID
        
        // let the image be the edited (cropped) image selected by user; downcast to make UIimage type
        guard let image = info[.editedImage] as? UIImage else {return}
        
        // imageName takes on new UUID string
        let imageName = UUID().uuidString
        //print(imageName)
        // imagePath = url to user documents directory, referencing UUID
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        // grab jpeg data from selected image and write contents to the imagePath, referencing UUID string info
        // writing image to this path is required for the cellForItemAt
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        // now that image selected is valid, and we have UUID + path to the image, instantiate new person with defaults below
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        // returns a URL to user documents folder user/library/developer/coresimulatar/devices.../documents
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // print(paths)
        return paths[0]
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        // Challenge 1: Add a second UIAlertController that gets shown when the user taps a picture, asking them whether they want to rename the person or delete them.
        let ac = UIAlertController(title: "Select an option:", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Rename", style: .default, handler: { [weak self] _ in
            let ac = UIAlertController(title: "Enter new name:", message: nil, preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak ac] _ in
                guard let newName = ac?.textFields?[0].text else {return}
                person.name = newName
                self?.collectionView.reloadData()
            }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(ac, animated: true)
        }))
        ac.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
            let ac = UIAlertController(title: "Confirm delete?", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                // delete the person (just delete cell for now)
                self?.people.remove(at: indexPath.item)
                self?.collectionView.reloadData()
            }))
            
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(ac, animated: true)
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func renamePerson() {
        
    }
    
    @objc func deletePerson() {
        
    }

}


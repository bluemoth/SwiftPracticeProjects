//
//  Person.swift
//  Project10_NamesToFaces
//
//  Created by Jacob Case on 2/8/22.
//

import UIKit

// class person that inherits from NSObject class (like many other system classes)
// Notes: person must inherit from NSObject in order to use NSCoding.
// person must be a class for inheritance to work with NSCoding/object
// Benefit with this method is that we can maintain this code alongside C-obj

class Person: NSObject, NSCoding {
    var name: String
    var image: String
    
    // default initializer setting name and image
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }
    
}

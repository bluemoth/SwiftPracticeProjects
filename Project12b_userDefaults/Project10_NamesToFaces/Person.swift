//
//  Person.swift
//  Project10_NamesToFaces
//
//  Created by Jacob Case on 2/8/22.
//

import UIKit

// class person that inherits from NSObject class (like many other system classes)

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    // default initializer setting name and image
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
}

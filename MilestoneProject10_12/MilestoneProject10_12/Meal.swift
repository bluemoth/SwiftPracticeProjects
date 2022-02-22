//
//  Meal.swift
//  MilestoneProject10_12
//
//  Created by Jacob Case on 2/21/22.
//

import Foundation

class Meal : NSObject {
    var name: String
    var date: String
    var image: String
    
    init(name: String, date: String, image: String)
    {
        self.name = name
        self.date = date
        self.image = image
    }
}

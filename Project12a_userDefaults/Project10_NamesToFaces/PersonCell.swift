//
//  PersonCell.swift
//  Project10_NamesToFaces
//
//  Created by Jacob Case on 2/8/22.
//

import UIKit

// custom person cell, created through main storyboard and extended here for access

class PersonCell: UICollectionViewCell {
    // imageView to hold a selected image from picker
    @IBOutlet weak var imageView: UIImageView!
    // name label to be populated in viewcontroller
    @IBOutlet weak var name: UILabel!
    
}

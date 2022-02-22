//
//  MealCell.swift
//  MilestoneProject10_12
//
//  Created by Jacob Case on 2/21/22.
//

import UIKit

class MealCell: UITableViewCell {

    
    @IBOutlet var Protein: UITextField!
    @IBOutlet var cellBubble: UIView!
    @IBOutlet var mealImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellBubble.layer.cornerRadius = cellBubble.frame.size.height / 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
}

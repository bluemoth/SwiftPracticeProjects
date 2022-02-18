//
//  Pictures.swift
//  Project1_StormViewer
//
//  Created by Jacob Case on 2/17/22.
//

import UIKit

class Pictures: NSObject, NSCoding {

    var picture: String
    var tapCount: Int
    
    init(picture: String, tapCount: Int) {
        self.picture = picture
        self.tapCount = tapCount
    }
    
    required init?(coder aDecoder: NSCoder) {
        picture = aDecoder.decodeObject(forKey: "picture") as? String ?? ""
        tapCount = aDecoder.decodeInteger(forKey: "tapcount")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(picture, forKey: "picture")
        aCoder.encode(tapCount, forKey: "tapcount")
    }

}

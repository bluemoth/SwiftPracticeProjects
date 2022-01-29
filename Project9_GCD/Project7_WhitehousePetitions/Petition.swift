//
//  Petition.swift
//  Project7_WhitehousePetitions
//
//  Created by Jacob Case on 1/25/22.
//

import Foundation


struct Petition : Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

//
//  TableCellModel.swift
//  cityride
//
//  Created by Matthew Attou on 5/21/16.
//  Copyright © 2016 Matthew Attou. All rights reserved.
//

import Foundation

class TableCellModel: NSObject {
    
    var name:String
    var price:String
    var distance:String
    var imageType:String
    
    init(name: String, price: String, distance: String, imageType: String) {
        
        self.name = name
        self.price = price
        self.distance = distance
        self.imageType = imageType
    }
}

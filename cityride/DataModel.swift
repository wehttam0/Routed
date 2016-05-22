//
//  DataModel.swift
//  cityride
//
//  Created by Matthew Attou on 5/21/16.
//  Copyright © 2016 Matthew Attou. All rights reserved.
//

import Foundation

class DataModel: NSObject {
    
    var lat:String
    var lng:String
    
    init(lat: String, lng: String) {
        
        self.lat = lat
        self.lng = lng
    }
}

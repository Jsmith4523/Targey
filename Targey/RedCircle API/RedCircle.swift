//
//  RedCircleProvider.swift
//  Targey
//
//  Created by Jaylen Smith on 12/26/22.
//

import Foundation

class RedCircle {
    
    let key: String
    
    init(resourceName: String = "Keys") {
        guard let resource = Bundle.main.path(forResource: resourceName, ofType: "plist"), let plist = NSDictionary(contentsOfFile: resource) else {
            fatalError("Failed to find resource \(resourceName). I'm going to end it all now! 🔫")
        }
        guard let key = plist.object(forKey: "RED_CIRCLE_API_KEY") as? String else {
            fatalError("RED_CIRCLE_API_KEY cannot be found!")
        }
        self.key = key
    }
}

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
            fatalError("Unable to locate resource file within Bundle! Please check for file and try again!")
        }
        guard let key = plist.object(forKey: "RED_CIRCLE_API_KEY") as? String else {
            fatalError("Please include your RedCircle API key within the Keys.plist file and try again!")
        }
        self.key = key
    }
}

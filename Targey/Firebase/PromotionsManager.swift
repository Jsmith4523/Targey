//
//  PromotionsManager.swift
//  Targey
//
//  Created by Jaylen Smith on 1/10/23.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase


enum PMFetchError: Error {
    case error(String)
}

final class PromotionsManager {
    
    private let database = Database.database()
    
    func fetchAllPromotions(completion: (Result<[Promotion], PMFetchError>)) {
        database.reference().getData { err, snapshot in
            guard err == nil, let value = snapshot?.value else {
                return
            }
            
            if let value = value as? [String: [String: Any]] {
                
            }
        }
    }
}

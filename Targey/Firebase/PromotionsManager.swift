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
    
    func fetchAllPromotions(completion: @escaping (Result<[Promotion], PMFetchError>) -> Void) {
        var promotions = [Promotion]()
        
        database.reference().getData { err, snapshot in
            guard err == nil, let value = snapshot?.value else {
                completion(.failure(.error("There was an error search for the latest promotions!")))
                return
            }
            
            if let value = value as? [String: [String: Any]] {
                value.forEach { _, value in
                    let promotion: Promotion = .init(title: value["title"] as! String,
                                                     prompt: value["prompt"] as! String,
                                                     searchTerm: value["search_term"] as! String,
                                                     bannerImgURL: value["img_url"] as! String)
                    promotions.append(promotion)
                }
            } else {
                completion(.failure(.error("Target promotions will appear here. Stay on the lookout for any future promotions.")))
            }
            completion(.success(promotions))
        }
    }
}

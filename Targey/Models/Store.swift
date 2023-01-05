//
//  Store.swift
//  Targey
//
//  Created by Jaylen Smith on 12/22/22.
//

import Foundation

//{
//      "position": 1,
//      "store_name": "Cedar Rapids South",
//      "store_id": "1771",
//      "in_stock": true,
//      "stock_level": 8,
//      "address": "3400 Edgewood Rd SW",
//      "city": "Cedar Rapids",
//      "state": "Iowa",
//      "zipcode": "52404-7214",
//      "phone": "319-396-4444",
//    },

struct StoreResponse: Decodable {
    let store_stock_results: [Store]
}

struct Store: Decodable, Comparable {
    
    let store_name: String?
    let store_id: String?
    let in_stock: Bool?
    let stock_level: Int?
    let address: String?
    let city: String?
    let state: String?
    let zipcode: String?
    let phone: String?
    let distance: Double?
    
    static func < (lhs: Store, rhs: Store) -> Bool {
        lhs.storeDistance < rhs.storeDistance
    }
    static func > (lhs: Store, rhs: Store) -> Bool {
        lhs.storeDistance > rhs.storeDistance
    }
}

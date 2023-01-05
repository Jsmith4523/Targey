//
//  Store+EXT.swift
//  Targey
//
//  Created by Jaylen Smith on 12/24/22.
//

import Foundation

extension Store {
    
    /*Testing out new Swift 5 unwrapping optional
     unwrapping syntax
     */
    
    var storeName: String {
        guard let store_name else {
            return ""
        }
        return store_name
    }
    
    var storeID: String {
        guard let store_id else {
            return ""
        }
        return store_id
    }
    
    var inStock: Bool {
        guard let in_stock else {
            return false
        }
        return in_stock
    }
    
    var stockLevel: String {
        guard let stock_level else {
            return "Contact Store"
        }
        return "\(stock_level)"
    }
    
    ///Compare with favorite store address
    var compareAddress: String {
        guard let address else {
            return ""
        }
        return address
    }
    
    ///The full address of a store
    var fullAddress: String {
        var str = ""
        
        if let address {
            str += address+", "
        }
        if let city {
            str += city+", "
        }
        if let state {
            str += state
        }
        if let zipcode {
            str += zipcode
        }
        
        return str
    }
    
    var phoneNumber: String {
        guard let phone else {
            return ""
        }
        return phone
    }
    
    var storeDistance: String {
        guard let distance else {
            return "0"
        }
        return "\(Int(distance))"
    }
}

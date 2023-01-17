//
//  CDShopItem+EXT.swift
//  Targey
//
//  Created by Jaylen Smith on 1/16/23.
//

import Foundation
import CoreData

extension ShoppingItem {
    
    func calculation() -> Double {
        return Double(Int(self.quantity) * Int(self.price))
    }
}

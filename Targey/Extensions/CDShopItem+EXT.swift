//
//  CDShopItem+EXT.swift
//  Targey
//
//  Created by Jaylen Smith on 1/16/23.
//

import Foundation
import CoreData

extension ShoppingItem {
    
    ///Items price times its quantity with the user Locale Currency symbol
    var totalFormatted: String {
        return String.userCurrencySymbol+String(format: "%0.2f", self.priceCalclated)
    }
    
    ///Items price not times its quantity
    var priceFormatted: String {
        String.userCurrencySymbol+String(format: "%0.2f", self.price)
    }
    
    ///If a shopping Item has a price or not
    var hasPrice: Bool {
        !self.price.isZero
    }
    
    ///Item price times its quantty
    private var priceCalclated: Double {
        Double(Double(self.quantity) * self.price)
    }
    
    static func getTotalOfEntireShoppingList(_ items: [ShoppingItem]) -> String? {
        var finalAmount: Double = 0.00
        var amounts = [Double]()
        
        for item in items where item.hasPrice {
            amounts.append(item.priceCalclated)
        }
        
        for amount in amounts {
            finalAmount += amount
        }
        
        if !(finalAmount == 0.00) {
            return String.userCurrencySymbol+String(format: "%0.2f", finalAmount)
        } else {
            return nil
        }
    }
}

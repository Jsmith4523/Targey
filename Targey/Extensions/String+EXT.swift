//
//  String+EXT.swift
//  Targey
//
//  Created by Jaylen Smith on 1/7/23.
//

import Foundation

extension String {
        
    static var userCurrency: String {
        return Locale.current.currencyCode ?? "USD"
    }
    
    static var userCurrencySymbol: String {
        return Locale.current.currencySymbol ?? "$"
    }
}

//
//  Double+EXT.swift
//  Targey
//
//  Created by Jaylen Smith on 1/23/23.
//

import Foundation


extension Double {
    
    ///Will automatically add the Locale currency symbol from the user with the price formatted two decimal digits
    func fullStringPrice() -> String {
        return .userCurrencySymbol+String(format: "%0.2f", self)
    }
}

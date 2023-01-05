//
//  ScannedProduct+EXT.swift
//  Targey
//
//  Created by Jaylen Smith on 12/25/22.
//

import Foundation

extension ScannedProduct {
    
    var productLink: URL {
        guard let link, let url = URL(string: link) else {
            return URL(string: "https://www.target.com")!
        }
        return url
    }
    
    var productRating: String {
        guard let rating else {
            return "0"
        }
        return "\(rating)"
    }
    
    var productUpc: String {
        guard let upc else {
            return ""
        }
        return upc
    }
    
    var productDpci: String {
        guard let dpci else {
            return ""
        }
        return dpci
    }
    
    var productMainImage: URL? {
        guard let main = main_image, let url = URL(string: main.link) else {
            return nil
        }
        return url
    }
    
    var productImages: [String] {
        var arr = [String]()
        
        images.forEach { link in
            guard let link = link else {
                return
            }
            arr.append(link.link)
        }
        return arr
    }
    
    var productFeatureBullets: [String] {
        var arr = [String]()
        
        feature_bullets.forEach { string in
            guard let str = string else {
                return
            }
            arr.append(str)
        }
        return arr
    }
}

extension buybox_winnder {
    
    var symbol: String {
        var symbol = "S"
        
        guard let priceSymbol = price?.currency_symbol else {
            return symbol
        }
        symbol = priceSymbol
        
        guard let wasSymbol = was_price?.currency_symbol else {
            return "S"
        }
        symbol = wasSymbol
        
        return symbol
    }
    
    var productPrice: String {
        guard let price = price?.value else {
            return "Contact Store"
        }
        
        return "\(symbol)\(price)"
    }
    
    var wasPrice: String {
        guard let price = was_price?.value else {
            return "Contact Store"
        }
        
        return "\(symbol)\(price)"
    }
}



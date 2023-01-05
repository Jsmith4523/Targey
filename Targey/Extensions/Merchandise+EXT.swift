//
//  Extensions.swift
//  Targey
//
//  Created by Jaylen Smith on 12/21/22.
//

import Foundation
import UIKit

extension product {
    
    var targetURL: URL {
        guard let link = self.link else {
            return URL(string: "https://target.com")!
        }
        
        guard let url = URL(string: link) else {
            return URL(string: "https://target.com")!
        }
        return url
    }

    var productTcin: String {
        guard let tcin = self.tcin else {
            return ""
        }
        return tcin
    }
    
    var productDcip: String {
        guard let dcpi = self.dpci else {
            return ""
        }
        return dcpi
    }
    
    var productBullets: [String] {
        guard let bullets = feature_bullets else {
            return [""]
        }
        return bullets
    }
    
    var productRating: Double {
        guard let rating = rating else {
            return 0
        }
        return rating
    }
    
    var productRatingTotal: Int {
        guard let ratingTotal = rating_total else {
            return 0
        }
        return ratingTotal
    }
    
    var mainProductImageURL: URL? {
        guard let string = main_image else {
            return nil
        }
        
        guard let url = URL(string: string) else {
            return nil
        }
        
        return url
    }
    
    var productImagesURL: [URL] {
        var urls = [URL]()
        
        self.images.forEach { string in
            guard let urlString = string else {
                return
            }
            
            guard let url = URL(string: urlString) else {
                return
            }
            
            urls.append(url)
        }
        
        return urls
    }
}

extension primary {
    
    var activeSale: Bool {
        guard self.price != nil else {
            return false
        }
        
        guard self.regular_price != nil else {
            return false
        }
        
        return true
    }
    
    var productSymbol: String {
        guard let symbol = self.symbol else {
            return "$"
        }
        return symbol
    }
    
    ///The sale price of a product
    var productSalePrice: String {
        guard let price = self.price else {
            return "Visit Store"
        }
        
        return "\(productSymbol)\(price)"
    }
    
    ///The price of a product; will show only sale price if regular is nil
    var productRegularPrice: String {
        var str = "Visit Store"
        
        if let regular = self.regular_price {
            str = productSymbol+"\(regular)"
            return str
        }
        
        guard let sale = self.price else {
            return str
        }
                
        str = productSymbol+"\(sale)"
        
        return str
    }
}

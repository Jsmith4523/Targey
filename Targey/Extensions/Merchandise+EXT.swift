//
//  Extensions.swift
//  Targey
//
//  Created by Jaylen Smith on 12/21/22.
//

import Foundation
import UIKit
import SwiftUI

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
    
    var productUpc: String {
        guard let upc else {
            return ""
        }
        return upc
    }
    
    var productBullets: [String] {
        guard let bullets = feature_bullets else {
            return [""]
        }
        return bullets
    }
    
    var productBio: String {
        var bio = ""
        
        if let bullets = feature_bullets {
            bullets.forEach {
                bio += $0
            }
        }
        return bio
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
        
        if let images {
            images.forEach { string in
                guard let urlString = string else {
                    return
                }
                
                guard let url = URL(string: urlString) else {
                    return
                }
                
                urls.append(url)
            }
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
    
    ///The sale price of a product
    var productSalePrice: String {
        guard let price = self.price else {
            return "Visit Store"
        }
        
        return price.fullStringPrice()
    }
    
    ///The price of a product; will show only sale price if regular is nil
    var productRegularPrice: String {
        var str = "Visit Store"
        
        if let regular = self.regular_price {
            str = regular.fullStringPrice()
            return str
        }
        
        guard let sale = self.price else {
            return str
        }
                
        str = sale.fullStringPrice()
        
        return str
    }
    
    ///Use when assigning the opnect to CoreData
    var productPriceValue: Double {
        if let price {
            return price
        } else {
            return 0
        }
    }
    
    var productPriceLabel: some View {
        HStack {
            if self.activeSale {
                Text(self.productRegularPrice)
                    .strikethrough(self.activeSale, color: .red)
                Text(self.productSalePrice)
                    .foregroundColor(.red)
            } else {
                Text(self.productRegularPrice)
            }
        }
    }
}

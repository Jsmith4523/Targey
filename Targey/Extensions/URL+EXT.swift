//
//  URL+EXT.swift
//  Targey
//
//  Created by Jaylen Smith on 12/21/22.
//

import Foundation
import UIKit

extension URL {
    
    ///RedCircle API URL to fetch JSON by term
    static func searchURL(term: String) -> URL? {
        guard let url = URL(string: "https://api.redcircleapi.com/request?api_key=API_KEY&type=search&search_term=\(term)&sort_by=best_seller") else {
            print("Cannot find anything by that term or url is broken!")
            return nil
        }
        return url
    }
    
    static func fetchStock(tcin: String, zipcode: String) -> URL? {
        guard let url = URL(string: "https://api.redcircleapi.com/request?api_key=API_KEY&type=store_stock&store_stock_zipcode=\(zipcode)&tcin=\(tcin)") else {
            return nil
        }
        return url
    }
    
    static func searchProductbyUPC(tcin: String, zipcode: String) -> URL? {
        guard let url = URL(string: "https://api.redcircleapi.com/request?api_key=API_KEY&type=product&gtin=\(tcin)") else {
            return nil
        }
        return url
    }
    
    static func openTargetURL(_ url: URL) {
        UIApplication.shared.open(url)
    }
}

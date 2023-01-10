//
//  Promotion.swift
//  Targey
//
//  Created by Jaylen Smith on 1/10/23.
//

import Foundation


struct Promotion: Identifiable, Codable {
    var id = UUID()
    var title: String
    var prompt: String
    var searchTerm: String
    var bannerImgURL: String
    
    var bannerURL: URL? {
        guard let url = URL(string: bannerImgURL) else {
            return nil
        }
        return url
    }
}

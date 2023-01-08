//
//  Merchandise.swift
//  Targey
//
//  Created by Jaylen Smith on 12/21/22.
//

import Foundation
import UIKit

//
//
//{
//         position: 1,
//         product: {
//            title: "Paper Mate Flair 5pk Felt Pens 0.7mm Medium Tip Multicolored",
//            link: "https://www.target.com/p/paper-mate-flair-5pk-felt-pens-0-7mm-medium-tip-multicolored/-/A-14463182",
//            tcin: "14463182",
//            dpci: "081-02-0494",
//            class_id: 2,
//            department_id: 81,
//            brand: "Paper Mate",
//            brand_link: "https://www.target.com/b/paper-mate/-/N-56c8g",
//            feature_bullets: [
//               "Add a blast of fun to all your writing",
//               "Medium Point felt tip for bold, expressive lines",
//               "Smear-resistant ink for less smudging",
//               "Water-based ink won't bleed through paper",
//               "The point guard prevents the tip from fraying",
//               "Includes 5 Flair pens in assorted colors"
//            ],
//            rating: 4.8,
//            ratings_total: 644,
//            main_image: "https://target.scene7.com/is/image/Target/GUEST_706f4031-ca3b-4a59-87b5-16fbe0fcf687",
//            images: [
//               "https://target.scene7.com/is/image/Target/GUEST_706f4031-ca3b-4a59-87b5-16fbe0fcf687",
//               "https://target.scene7.com/is/image/Target/GUEST_543f4e05-f171-4bb0-9859-b8d4188a45e1",
//               "https://target.scene7.com/is/image/Target/GUEST_2bad0909-097b-4f6c-8aaf-b992e6fe2621",
//               "https://target.scene7.com/is/image/Target/GUEST_06f1cef1-74d7-4bff-a216-1a25600467f3",
//               "https://target.scene7.com/is/image/Target/GUEST_b34ab9a7-172a-4703-956f-3ddf5998cbae",
//               "https://target.scene7.com/is/image/Target/GUEST_66401472-f8bf-452a-87b3-2eef97bb5f23",
//               "https://target.scene7.com/is/image/Target/GUEST_4cc15315-64c5-4d56-b790-d78a01847933",
//               "https://target.scene7.com/is/image/Target/GUEST_64e0955d-8623-4629-8869-d7e7e5ccd302",
//               "https://target.scene7.com/is/image/Target/GUEST_32932878-078e-4916-b596-fbeb5b384b24",
//               "https://target.scene7.com/is/image/Target/GUEST_a5458a26-5f5e-41b8-8937-4fe76d565f10"
//            ],
//            videos: [
//               {
//                  link: "https://target.scene7.com/is/content/Target/GUEST_ed214196-b36a-4de0-964e-2b2ddd1bc451_Flash9_Autox720p_2600k",
//                  type: "video/mp4"
//               },
//               {
//                  link: "https://target.scene7.com/is/content/Target/GUEST_f2a05f63-8412-4ef7-86bf-2569752b320b_Flash9_Autox720p_2600k",
//                  type: "video/mp4"
//               }
//            ]
//         },
//         offers: {
//            primary: {
//               price: 5.39,
//               currency: "USD",
//               symbol: "$"
//            },
//            all_offers: [
//               {
//                  price: 5.39,
//                  currency: "USD",
//                  symbol: "$"
//               }
//            ]
//         },
//         fulfillment: {
//            type: "1p"
//         }
//      }

struct MerchandiseResponse: Decodable {
    let search_results: [Merchandise]
}

struct Merchandise: Decodable, Comparable {

    let position: Int
    let product: product
    let offers: offers
    
    static func < (lhs: Merchandise, rhs: Merchandise) -> Bool {
        lhs.position < rhs.position
    }
    
    static func > (lhs: Merchandise, rhs: Merchandise) -> Bool {
        lhs.position > rhs.position
    }
    
    static func == (lhs: Merchandise, rhs: Merchandise) -> Bool {
        return false
    }
}

struct product: Decodable {
    let title: String
    let link: String?
    let tcin: String?
    let dpci: String?
    let feature_bullets: [String]?
    let rating: Double?
    let rating_total: Int?
    let main_image: String?
    let images: [String?]?
}

struct offers: Decodable {
    let primary: primary
}

struct primary: Decodable {
    let price: Double?
    let symbol: String?
    let regular_price: Double?
}


//
//  ScannedProduct.swift
//  Targey
//
//  Created by Jaylen Smith on 12/25/22.
//

import Foundation

//
//"tcin": "78025470",
//    "title": "Sharpie Pocket 4pk Highlighters Narrow Chisel Tip Multicolored",
//    "link": "https://www.target.com/p/sharpie-pocket-4pk-highlighters-narrow-chisel-tip-multicolored/-/A-78025470",
//    "breadcrumbs": [
//      {
//        "name": "Target",
//        "link": "https://www.target.com/"
//      },
//      {
//        "name": "School & Office Supplies",
//        "link": "https://www.target.com/c/school-office-supplies/-/N-5xsxr"
//      },
//      {
//        "name": "Highlighters",
//        "link": "https://www.target.com/c/highlighters-writing-supplies-school-office/-/N-4yjut"
//      }
//    ],
//    "brand": "Sharpie",
//    "brand_link": "https://www.target.com/b/sharpie/-/N-56cak",
//    "rating": 4.8,
//    "ratings_total": 415,
//    "upc": "071641174603",
//    "dpci": "081-02-3451",
//    "main_image": {
//      "link": "https://target.scene7.com/is/image/Target/GUEST_dd2740a1-b9a7-4a4f-906d-3244ff2b517e?wid=1000&hei=1000&qlt=100"
//    },
//    "images": [
//      {
//        "link": "https://target.scene7.com/is/image/Target/GUEST_dd2740a1-b9a7-4a4f-906d-3244ff2b517e?wid=1000&hei=1000&qlt=100"
//      },
//      {
//        "link": "https://target.scene7.com/is/image/Target/GUEST_29507d0a-f7ee-483e-b6c1-72237ea26e7a?wid=1000&hei=1000&qlt=100"
//      },
//      {
//        "link": "https://target.scene7.com/is/image/Target/GUEST_a6980245-9cab-435d-8469-4f01064e04b8?wid=1000&hei=1000&qlt=100"
//      },
//      {
//        "link": "https://target.scene7.com/is/image/Target/GUEST_3680fd7d-ecec-40a9-a13d-7722546532ca?wid=1000&hei=1000&qlt=100"
//      }
//    ],
//    "feature_bullets": [
//      "Bright, easy-to-see colors make your highlighted text easy to read",
//      "Resists smearing of many pen and marker inks (let ink dry before highlighting)",
//      "Easy-glide, narrow chisel tip is great for highlighting, underlining or writing notes",
//      "Slim shape is easy to control and slips into backpacks or notebooks",
//      "Includes: Fluorescent Pink, Yellow, Orange and Blue highlighters"
//    ],
//    "buybox_winner": {
//      "price": {
//        "currency_symbol": "$",
//        "currency": "USD",
//        "value": 279.99
//      },
//      "was_price": {
//        "value": 329.99,
//        "currency_symbol": "$",
//        "currency": "USD"
//      }
//    }


struct ScannedProductSource: Decodable {
    let product: ScannedProduct
}

struct ScannedProduct: Decodable {
    let title: String
    let link: String?
    let rating: Double?
    let upc: String?
    let dpci: String?
    let main_image: link?
    let images: [link?]
    let feature_bullets: [String?]
    let buybox_winner: buybox_winnder
}

struct buybox_winnder: Decodable {
    let price: price?
    let was_price: was_price?
}

struct price: Decodable {
    let currency_symbol: String?
    let value: Double?
}

struct was_price: Decodable {
    let value: Double?
    let currency_symbol: String?
}


struct link: Decodable {
    let link: String
}

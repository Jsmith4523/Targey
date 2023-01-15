//
//  ScannedProductInformationView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/15/23.
//

import Foundation
import SwiftUI

struct ScannedProductInformationView: View {
    
    let merchandise: Merchandise
    let upc: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    AsyncImage(url: merchandise.product.mainProductImageURL!) { img in
                        img
                            .scannedProductImageStyle()
                    } placeholder: {
                        Image.placeholderProductImage
                            .scannedProductImageStyle()
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text(merchandise.product.title)
                            .font(.system(size: 15).weight(.medium))
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        ratingView(rating: merchandise.product.productRating, reviewCount: 0)
                        merchandise.offers.primary.productPriceLabel
                            .font(.system(size: 15))
                    }
                }
                .frame(height: 85)
            }
            DiscoverContentSection(header: "Details") {
                ForEach(merchandise.product.productBullets, id: \.self) {
                    Text($0)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 15))
                }
            }
            DiscoverContentSection(header: "Additional Information") {
                VStack(alignment: .leading) {
                    Text("DPCI: \(merchandise.product.productDcip)")
                    Text("TCIN: \(merchandise.product.productTcin)")
                    Text("UPC: \(upc)")
                }
                .font(.system(size: 14))
                .foregroundColor(.gray)
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

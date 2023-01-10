//
//  SearchResultsView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/10/23.
//

import Foundation
import SwiftUI

struct SearchResultsView: View {
   
   @Binding var searchField: String
   
   @ObservedObject var searchModel: SearchViewModel
   
   var body: some View {
       ScrollView {
           VStack {
               ForEach(searchModel.merchandises, id: \.position) { merchandise in
                   NavigationLink {
                       SelectedMerchandiseView(merchandise: merchandise, searchModel: searchModel)
                   } label: {
                       MerchandiseItemCellView(merchandise: merchandise, searchModel: searchModel)
                   }
                   Divider()
               }
               Spacer()
                   .frame(height: 85)
           }
       }
       .refreshable {
           searchModel.fetchForProducts(term: searchField)
       }
   }
}


struct MerchandiseItemCellView: View {
    
    let merchandise: Merchandise
    
    var product: product {
        merchandise.product
    }
    
    var offer: offers {
        merchandise.offers
    }
            
    @ObservedObject var searchModel: SearchViewModel
    
    var body: some View {
        HStack {
            AsyncImage(url: product.mainProductImageURL!) { image in
                image.mainProductImageStyle()
            } placeholder: {
                Image.placeholderProductImage.mainProductImageStyle()
            }
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.system(size: 17).weight(.semibold))
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                HStack {
                    if offer.primary.activeSale {
                        Text(offer.primary.productRegularPrice)
                            .strikethrough(offer.primary.activeSale, color: .red)
                        Text(offer.primary.productSalePrice)
                            .foregroundColor(.red)
                    } else {
                        Text(offer.primary.productRegularPrice)
                    }
                }
            }
            Spacer()
        }
        .accentColor(.reversed)
        .padding()
        .contextMenu {
            Button {
                
            } label: {
                Label("Add to Shopping List", systemImage: "cart")
            }
            Button {
                
            } label: {
                Label("Favorite", systemImage: "heart")
            }
        }
    }
}

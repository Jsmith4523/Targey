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
    @StateObject private var nearestVM = NearestStoreModel()
    
    init(merchandise: Merchandise, searchModel: SearchViewModel) {
        self.merchandise = merchandise
        self.searchModel = searchModel
        
//        print("I'm created! \(Date.now.formatted(.dateTime.hour().minute())) for \(merchandise.product.title)")
    }
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: product.mainProductImageURL!) { image in
                image.mainProductImageStyle()
            } placeholder: {
                Image.placeholderProductImage.mainProductImageStyle()
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(product.title)
                    .font(.system(size: 16).weight(.semibold))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                offer.primary.productPriceLabel
                    .font(.system(size: 16))
                
                if let nearestStore = nearestVM.store {
                    Text(nearestStore.storeName)
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

//
//  ShoppingListMerchandiseResultsView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/7/23.
//

import Foundation
import SwiftUI


struct ShoppingListMerchandiseSearchView: View {
    
    @State private var searchField = ""
    
    @StateObject var searchModel = SearchViewModel()
    @ObservedObject var shopLM: ShoppingListViewModel
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TextField("Search", text: $searchField) {
                searchModel.fetchForProducts(term: searchField)
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            Spacer()
            ZStack {
                switch searchModel.isSearching {
                case true:
                    HangTightProgressView()
                case false:
                    switch searchModel.didFailToSearch {
                    case true:
                        NoResultsFoundView()
                    case false:
                        switch searchField.isEmpty {
                        case true:
                            EmptyView()
                        case false:
                            ShoppingListMerchandiseSearchResults(searchModel: searchModel, shopLM: shopLM)
                        }
                    }
                }
            }
        }
    }
}

struct ShoppingListMerchandiseSearchResults: View {
    
    @ObservedObject var searchModel: SearchViewModel
    @ObservedObject var shopLM: ShoppingListViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(searchModel.merchandises, id: \.position) { merchandise in
                    ShoppingListMerchandiseItemCellView(merchandise: merchandise, shopLM: shopLM)
                    Divider()
                }
            }
        }
    }
}

fileprivate struct ShoppingListMerchandiseItemCellView: View {
    
    let merchandise: Merchandise
    
    var product: product {
        merchandise.product
    }
    
    var offer: offers {
        merchandise.offers
    }
            
    @ObservedObject var shopLM: ShoppingListViewModel
    
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
                Spacer()
                    .frame(height: 10)
                Button {
                    
                } label: {
                    Text("Add")
                        .foregroundColor(.targetRed)
                }

            }
            Spacer()
        }
        .accentColor(.reversed)
        .padding()
    }
}


struct Previews_ShoppingListMerchandiseResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListMerchandiseSearchView(shopLM: ShoppingListViewModel())
    }
}

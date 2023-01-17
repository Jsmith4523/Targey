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
        NavigationView {
            VStack {
                HStack {
                    TextField("Search", text: $searchField) {
                        searchModel.fetchForProducts(term: searchField)
                    }
                    .textFieldStyle(.roundedBorder)
                    Spacer()
                    Button("Close") {
                        dismiss()
                    }
                }
                .padding()
                switch searchModel.isSearching {
                case true:
                    DogProgessView()
                case false:
                    switch searchModel.didFailToSearch {
                    case true:
                        NoResultsFoundView()
                    case false:
                        ShoppingListMerchandiseSearchResults(searchModel: searchModel, shopLM: shopLM)
                    }
                }
            }
        }
        .accentColor(.targetRed)
        .interactiveDismissDisabled()
    }
}

struct ShoppingListMerchandiseSearchResults: View {
    
    @ObservedObject var searchModel: SearchViewModel
    @ObservedObject var shopLM: ShoppingListViewModel
    
    @State private var selectedMerchandise: Merchandise? {
        didSet {
            isShowingSelectedMerchandiseQuantityView.toggle()
        }
    }
    
    @State private var isShowingSelectedMerchandiseQuantityView = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(searchModel.merchandises, id: \.position) { merchandise in
                    ShoppingListMerchandiseItemCellView(merchandise: merchandise, shopLM: shopLM)
                        .onTapGesture {
                            selectedMerchandise = merchandise
                        }
                    Divider()
                }
            }
        }
        .customSheetView(isPresented: $isShowingSelectedMerchandiseQuantityView, detents: [.medium()], cornerRadius: 15) {
            ShoppingListScannedItemView(merchandise: selectedMerchandise, searchModel: searchModel, shoppingLM: shopLM)
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
                image.shoppingListProductImageStyle()
            } placeholder: {
                Image.placeholderProductImage.shoppingListProductImageStyle()
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

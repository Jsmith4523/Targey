//
//  SearchView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/21/22.
//

import Foundation
import SwiftUI

struct SearchView: View {
    
    @State private var searchField = ""
    
    @State private var isShowingBarcodeScannerView = false
    
    @StateObject private var searchModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TextField("Search", text: $searchField, onEditingChanged: { _ in
                    searchModel.merchandises = []
                }) {
                    if !searchField.isEmpty {
                        searchModel.fetchForProducts(term: searchField)
                    }
                }
                .textFieldStyle(.roundedBorder)
                .padding()
                ZStack {
                    VStack {
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
                                    SearchInstruction()
                                case false:
                                    SearchResults(searchField: $searchField, searchModel: searchModel)
                                }
                            }
                        }
                    }
                    ScannerButton(isShowingBarcodeScannerView: $isShowingBarcodeScannerView, searchModel: searchModel)
                }
            }
            .accentColor(.targetRed)
        }
        .fullScreenCover(isPresented: $isShowingBarcodeScannerView) {
            BarcodeScannerView()
        }
    }
}

fileprivate struct ScannerButton: View {
    
    @Binding var isShowingBarcodeScannerView: Bool
    
    @ObservedObject var searchModel: SearchViewModel
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    isShowingBarcodeScannerView.toggle()
                } label: {
                    Image(systemName: "barcode.viewfinder")
                        .largeButtonStyle()
                }
            }
            .padding()
        }
    }
}
 struct HangTightProgressView: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image.dogOne
                .dogSymbolStyle()
            Text("Hang tight! We're running through aisles as fast as we can!")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
    }
}
 struct SearchResults: View {
    
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
 struct SearchInstruction: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image.cartwheel
                .cartwheelSymbolStyle()
            Text("Begin searching for everyday products!")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
    }
}


fileprivate struct ShoppingListResults: View {
    
    @ObservedObject var shopLM: ShoppingListViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(shopLM.shoppingItems) { item in
                    
                }
            }
        }
    }
}

 struct NoResultsFoundView: View {
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            storeGlyph()
            Text("We did the best we could. That product is no where to be found!")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
    }
}

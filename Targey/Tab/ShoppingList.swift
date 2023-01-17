//
//  ShoppingListView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/28/22.
//

import SwiftUI

struct ShoppingListView: View {
    
    @StateObject private var searchModel = SearchViewModel()
    @StateObject private var shopLM = ShoppingListViewModel()
    
    @State private var isShowingBarcodeScannerView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                switch shopLM.shoppingItems.isEmpty {
                case true:
                    ShoppingListEmptyView()
                case false:
                    ShoppingListItemsView(shopLM: shopLM)
                }
                AddShoppingItemButton(shopLM: shopLM)
            }
            .navigationTitle("Shopping List")
            .sheet(isPresented: $shopLM.isShowingSearchView) {
                ShoppingListMerchandiseSearchView(shopLM: shopLM)
            }
            .sheet(isPresented: $shopLM.isShowingManualView) {
                ShoppingListManualEnterView(shopLM: shopLM)
            }
            .fullScreenCover(isPresented: $shopLM.isShowingScannerView) {
                ShoppingListBarcodeScannerView(shopLM: shopLM)
            }
        }
        .onAppear {
            shopLM.fetchItemsFromList()
        }
    }
}


fileprivate struct ShoppingListItemsView: View {
    
    @ObservedObject var shopLM: ShoppingListViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(shopLM.shoppingItems.sorted(by: {$0.name! > $1.name!})) { item in
                    ShoppingListItemCellView(item: item, shopLM: shopLM)
                    Divider()
                }
            }
        }
    }
}

struct ShoppingListItemCellView: View {
    
    @State private var isShowingSelectedItemInformationView = false
        
    let item: ShoppingItem
    
    @ObservedObject var shopLM: ShoppingListViewModel
    
    var body: some View  {
        HStack {
            HStack(alignment: .top) {
                if let url = item.imgData {
                    AsyncImage(url: url) { img in
                        img.shoppingListProductImageStyle()
                    } placeholder: {
                        Image.placeholderProductImage.shoppingListProductImageStyle()
                    }
                } else {
                    Image.placeholderProductImage.shoppingListProductImageStyle()
                }
                VStack(alignment: .leading) {
                    Group {
                        Text(item.name ?? "Product")
                            .font(.system(size: 17).bold())
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                        Text("\(item.price)")
                            .font(.system(size: 15))
                            .multilineTextAlignment(.leading)
                    }
                    .foregroundColor(.reversed)
                    Text("x\(item.quantity)")
                        .font(.system(size: 14))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                }
                Spacer()
            
            }
            
            Menu {
                Button {
                    isShowingSelectedItemInformationView.toggle()
                } label: {
                   Label("Info", systemImage: "info.circle")
                }
                Button {
                    
                } label: {
                    Label("Update Quantity", systemImage: "plus")
                }
                Button(role: .destructive) {
                    shopLM.removeItemFromShoppingList(item)
                } label: {
                    Label("Remove", systemImage: "trash")
                }
            } label: {
                Image(systemName: "ellipsis")
            }
            .padding()
        }
        .padding()
        .customSheetView(isPresented: $isShowingSelectedItemInformationView, detents: [.medium()], showsIndicator: true, cornerRadius: 35) {
            SelectedItemInShoppingList(item: item)
        }
    }
}

fileprivate struct AddShoppingItemButton: View {
    
    @ObservedObject var shopLM: ShoppingListViewModel
        
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Menu {
                    Button {
                        shopLM.isShowingScannerView.toggle()
                    } label: {
                        Label("Scan", systemImage: "iphone.rear.camera")
                    }
                    Button {
                        shopLM.isShowingSearchView.toggle()
                    } label: {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    Button {
                        shopLM.isShowingManualView.toggle()
                    } label: {
                        Label("Manual", systemImage: "plus")
                    }
                } label: {
                    Image(systemName: "plus")
                        .largeButtonStyle()
                }
            }
            .padding()
        }
    }
}

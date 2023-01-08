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
                    ListIsEmptyView()
                case false:
                    ShoppingListItemsView(shopLM: shopLM)
                }
                AddShoppingItemButton(shopLM: shopLM)
            }
            .navigationTitle("Shopping List")
            .navigationBarTitleDisplayMode(.inline)
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
                ForEach(shopLM.shoppingItems) { item in
                    ShoppingListItemCellView(item: item, shopLM: shopLM)
                    Divider()
                }
            }
        }
        .toolbar {
            Button("Remove all") {
                shopLM.removeAllItemsFromShoppingList()
            }
            .foregroundColor(.targetRed)
        }
    }
}

struct ShoppingListItemCellView: View {
    
    let item: ShoppingItem
    
    @ObservedObject var shopLM: ShoppingListViewModel
    
    var productImage: Image {
        guard let data = item.imgData, let uiImage = UIImage(data: data) else {
            return .placeholderProductImage
        }
        return Image(uiImage: uiImage)
    }
    
    var body: some View  {
        HStack {
            productImage
                .resizable()
                .scaledToFit()
                .frame(width: 65, height: 65)
            VStack(alignment: .leading) {
                Text(item.name ?? "Item")
                    .font(.system(size: 17).weight(.semibold))
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                Text(item.price ?? "")
                    .font(.system(size: 15))
                Text("x\(item.quantity)")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
    }
}

fileprivate struct ListIsEmptyView: View {
        
    var body: some View {
        VStack {
            Spacer()
            Image.dogBag
                .resizable()
                .scaledToFit()
                .frame(width: 65, height: 65)
                .padding()
            Text("Your List is Empty")
                .font(.system(size: 23).bold())
            Text("Stay organized by adding everyday items that you can't live without.")
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
                
        }
        .padding()
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

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}

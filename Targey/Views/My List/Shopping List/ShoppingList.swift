//
//  ShoppingListView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/28/22.
//

import SwiftUI

struct ShoppingListView: View {
    
    @State private var collectedItems = Set<ShoppingItem>()
    
    @State private var isShowingBarcodeScannerView = false
    @State private var isCurrentlyEditing = false
    
    @StateObject private var searchModel = SearchViewModel()
    @ObservedObject var shopLM: ShoppingListViewModel
    
    var body: some View {
        ZStack {
            switch shopLM.shoppingItems.isEmpty {
            case true:
                ShoppingListEmptyView()
            case false:
                ShoppingListItemsView(isCurrentlyEditing: $isCurrentlyEditing, collectedItems: $collectedItems, shopLM: shopLM)
            }
            if isCurrentlyEditing {
                CollectedShoppingItemsButton(collectedItems: $collectedItems, isEditing: $isCurrentlyEditing, shopLM: shopLM)
            } else {
                AddShoppingItemButton(shopLM: shopLM)
            }
        }
        .navigationTitle("Shopping List")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $shopLM.isShowingSearchView) {
            ShoppingListMerchandiseSearchView(shopLM: shopLM)
        }
        .sheet(isPresented: $shopLM.isShowingManualView) {
            ShoppingListManualEnterView(shopLM: shopLM)
        }
        .fullScreenCover(isPresented: $shopLM.isShowingScannerView) {
            ShoppingListBarcodeScannerView(shopLM: shopLM)
        }
        .onChange(of: isCurrentlyEditing) { _ in
            collectedItems.removeAll()
        }
    }
}


fileprivate struct ShoppingListItemsView: View {
    
    @Binding var isCurrentlyEditing: Bool
    @Binding var collectedItems: Set<ShoppingItem>
    
    @State private var isShowingOptionDialog = false
    @State private var alertOfRemovingAllItems = false
    
    @ObservedObject var shopLM: ShoppingListViewModel
            
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(shopLM.shoppingItems.sorted(by: {$0.name ?? "" > $1.name ?? ""})) { item in
                    ShoppingListItemCellView(collectedItems: $collectedItems, isCurrentlyEditing: $isCurrentlyEditing, item: item, shopLM: shopLM)
                    Divider()
                }
                Spacer()
                    .frame(height: 70)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if !isCurrentlyEditing {
                    Button {
                        isCurrentlyEditing.toggle()
                    } label: {
                        Image(systemName: "checkmark.circle")
                    }
                    Button {
                        isShowingOptionDialog.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                } else {
                    Button("Done") {
                        isCurrentlyEditing.toggle()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(isCurrentlyEditing)
        .alert("Remove all?", isPresented: $alertOfRemovingAllItems, actions: {
            Button("Yes, remove", role: .destructive) {
                shopLM.removeAllItemsFromShoppingList()
            }
            Button("Cancel") {}
        }, message: {
            Text("Once done, you cannot undo this action!")
        })
        .confirmationDialog("", isPresented: $isShowingOptionDialog) {
            Button("Remove all", role: .destructive) {
                alertOfRemovingAllItems.toggle()
            }
            Button("Cancel") {}
        } message: {
            Text("What would you like to do")
        }
    }
}

struct ShoppingListItemCellView: View {
    
    @Binding var collectedItems: Set<ShoppingItem>
    @Binding var isCurrentlyEditing: Bool
    
    @State private var isShowingSelectedItemInformationView = false
    
    //User has collected this shopping list item(s) and would like to remove it
    @State private var didSelectedItemForCompletion = false {
        didSet {
            UIImpactFeedbackGenerator().impactOccurred(intensity: 5)
            if didSelectedItemForCompletion {
                collectedItems.insert(item)
            } else {
                collectedItems.remove(item)
            }
        }
    }
        
    let item: ShoppingItem
    
    @ObservedObject var shopLM: ShoppingListViewModel
    
    var body: some View  {
        HStack {
            HStack(alignment: .top) {
                if let url = item.imgUrl {
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
                        Text("$\(item.price)")
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
            
                if isCurrentlyEditing {
                    Image(systemName: didSelectedItemForCompletion ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(didSelectedItemForCompletion ? .green : .gray)
                        .onTapGesture {
                            didSelectedItemForCompletion.toggle()
                        }
                }
            }
            
            if !isCurrentlyEditing {
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
        }
        .padding()
        .customSheetView(isPresented: $isShowingSelectedItemInformationView, detents: [.medium()], showsIndicator: true, cornerRadius: 35) {
            SelectedItemInShoppingList(item: item)
        }
        .onChange(of: isCurrentlyEditing) { _ in
            didSelectedItemForCompletion = false
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

fileprivate struct CollectedShoppingItemsButton: View {
    
    @Binding var collectedItems: Set<ShoppingItem>
    @Binding var isEditing: Bool
    
    @ObservedObject var shopLM: ShoppingListViewModel
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    shopLM.removeUserCollectedItems(collectedItems) { success in
                        isEditing = success
                    }
                } label: {
                    Image(systemName: "cart.fill.badge.minus")
                        .largeButtonStyle(backgroundColor: collectedItems.isEmpty ? .gray : .green)
                }
            }
            .padding()
            .disabled(collectedItems.isEmpty)
        }
    }
}

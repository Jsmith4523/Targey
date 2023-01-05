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
    @State private var isShowingAddOptionsView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                switch shopLM.shoppingItems.isEmpty {
                case true:
                    ListIsEmptyView(isShowingAddOptionsView: $isShowingAddOptionsView)
                case false:
                    ShoppingListResults(shopLM: shopLM)
                }
            }
            .navigationTitle("Shopping List")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



fileprivate struct ListIsEmptyView: View {
    
    @Binding var isShowingAddOptionsView: Bool
    
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

fileprivate struct AddShoppingItemButton: View {
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Menu {
                    
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

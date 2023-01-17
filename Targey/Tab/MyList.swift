//
//  MyList.swift
//  Targey
//
//  Created by Jaylen Smith on 1/17/23.
//

import SwiftUI

struct MyList: View {
    
    @StateObject private var shopLM = ShoppingListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 20)
                HStack {
                    NavigationLink {
                        ShoppingListView(shopLM: shopLM)
                    } label: {
                        MyListOptionCellView(title: "Shopping List", image: "cart")
                    }
                    NavigationLink {
                        EmptyView()
                    } label: {
                        MyListOptionCellView(title: "Favorites", image: "heart.fill")
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .navigationTitle("MyList")
            .onAppear {
                shopLM.fetchItemsFromList()
            }
        }
    }
}

fileprivate struct MyListOptionCellView: View {
    
    let title: String
    let image: String
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.targetRed)
            Spacer()
            Text(title)
                .foregroundColor(.reversed)
                .font(.system(size: 18).bold())
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width/2-20, height: 200)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .overlay {
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.gray.opacity(0.3))
        }
    }
}

struct MyList_Previews: PreviewProvider {
    static var previews: some View {
        MyList()
            .preferredColorScheme(.light)
    }
}

//
//  SelectedItemInShoppingList.swift
//  Targey
//
//  Created by Jaylen Smith on 1/16/23.
//

import SwiftUI

struct SelectedItemInShoppingList: View {
    
    let item: ShoppingItem?
    
    @Environment (\.managedObjectContext) var context
    
    var body: some View {
        NavigationView {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    DiscoverContentSection(header: "Product") {
                        Text(item?.name ?? "Product")
                            .font(.system(size: 15))
                            .multilineTextAlignment(.leading)
                    }
                    DiscoverContentSection(header: "Calculation") {
                        VStack(alignment: .leading) {
                            Text("Price: \(item?.price ?? 0)")
                            Text("Quantity: \(Int(item?.quantity ?? 0))")
                            Text("Total without Tax: $"+(item?.calculation() ?? ""))
                            
                        }
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                    }
                    DiscoverContentSection(header: "Identities") {
                        VStack(alignment: .leading) {
                            Text("DPCI: \(item?.dpci ?? "")")
                            Text("UPC: \(item?.upc ?? "")")
                            Text("TCIN: \(item?.tcin ?? "")")
                        }
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Additional Information")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

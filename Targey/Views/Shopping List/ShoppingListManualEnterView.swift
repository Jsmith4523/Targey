//
//  ShoppingListManualEnterView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/7/23.
//

import Foundation
import SwiftUI

struct ShoppingListManualEnterView: View {
    
    @State private var name = ""
    @State private var price = 0.00
    @State private var quantity = 1
    @State private var upc = ""
    @State private var dpci = ""
    @State private var tcin = ""
    
    @ObservedObject var shopLM: ShoppingListViewModel
    
    @Environment (\.dismiss) var dismiss
    
    var scannedUpc: String?
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Name of Product", text: $name)
                        .keyboardType(.numbersAndPunctuation)
                    TextField("Retail Price", value: $price, format: .currency(code: .userCurrency))
                        .keyboardType(.decimalPad)
                    Stepper("Quantity (\(quantity))", value: $quantity)
                } header: {
                    Text("Required information")
                }
                
                Section {
                    TextField("UPC", text: $upc)
                        .keyboardType(.numberPad)
                    TextField("DPCI", text: $dpci)
                        .keyboardType(.numberPad)
                    TextField("TCIN", text: $tcin)
                        .keyboardType(.numberPad)
                } header: {
                    Text("Additional Information")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Save") {
                        prepareMerchandise()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .navigationTitle("Manual Entry")
            .navigationBarTitleDisplayMode(.inline)
            .tint(.targetRed)
        }
        .interactiveDismissDisabled()
        .onAppear {
            if let scannedUpc {
                self.upc = scannedUpc
            }
        }
    }
    
    private func prepareMerchandise() {
        let merchandise = Merchandise(position: 0, product: .init(title: name, link: nil, tcin: tcin, dpci: dpci, feature_bullets: nil, rating: nil, rating_total: nil, main_image: nil, images: nil), offers: .init(primary: .init(price: nil, symbol: .userCurrencySymbol, regular_price: Double(price))))
        shopLM.addItemToShoppingList(merchandise, quantity: quantity) { didSave  in
            if didSave {
                dismiss()
            }
        }
    }
}

struct ShoppingListManualEnterView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListManualEnterView(shopLM: ShoppingListViewModel(), scannedUpc: "12432")
    }
}

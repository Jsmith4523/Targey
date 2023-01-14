//
//  ShoppingListScannedItemView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/14/23.
//

import SwiftUI

struct ShoppingListScannedItemView: View {
    
    @State private var alertOfErrorToSave = false
    
    @State private var quantity = 1
    
    var merchandise: Merchandise? {
        searchModel.scannedMerchandise
    }
    
    @ObservedObject var searchModel: SearchViewModel
    @ObservedObject var shoppingLM: ShoppingListViewModel
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        if let merchandise {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Add Product")
                            .font(.system(size: 18).bold())
                        Spacer()
                    }
                    HStack {
                        AsyncImage(url: merchandise.product.mainProductImageURL!) { img in
                            img
                                .scannedProductImageStyle()
                        } placeholder: {
                            Image.placeholderProductImage
                                .scannedProductImageStyle()
                        }
                        VStack(alignment: .leading) {
                            Text(merchandise.product.title)
                                .font(.system(size: 15).bold())
                            merchandise.offers.primary.productPriceLabel
                                .font(.system(size: 14))
                        }
                    }
                    if merchandise.offers.primary.activeSale {
                        Text("This product has an active sale. Adding this product to your shopping list will only show its retail price.")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    Stepper("Quantity (\(quantity))", value: $quantity, in: 1...10)
                        .font(.system(size: 14))
                }
                .padding()
                Spacer()
                Divider()
                Button {
                    prepareMerchandise()
                } label: {
                    Text("Save")
                }
            }
            .alert("Failed to save", isPresented: $alertOfErrorToSave) {
                Button("OK") {}
            } message: {
                Text("That item could not be saved to your shopping list. Perhaps try again at a later time?")
            }
        }
    }
    
    private func prepareMerchandise() {
        if let merchandise {
            shoppingLM.addItemToShoppingList(merchandise, quantity: quantity) {
                switch $0 {
                case true:
                    dismiss()
                case false:
                    alertOfErrorToSave.toggle()
                }
            }
        } else {
            alertOfErrorToSave.toggle()
        }
    }
}

struct ShoppingListScannedItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListScannedItemView(searchModel: SearchViewModel(), shoppingLM: ShoppingListViewModel())
    }
}

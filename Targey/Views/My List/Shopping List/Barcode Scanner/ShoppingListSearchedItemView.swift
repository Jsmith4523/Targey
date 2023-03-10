//
//  ShoppingListScannedItemView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/14/23.
//

import SwiftUI

struct ShoppingListSearchedItemView: View {
    
    @State private var alertOfErrorToSave = false
    @State private var quantity = 1
    
    @Binding var merchandise: Merchandise?
        
    @ObservedObject var searchModel: SearchViewModel
    @ObservedObject var shoppingLM: ShoppingListViewModel
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        if searchModel.isFindingScannedProduct {
            DogProgessView()
        } else {
            if let merchandise {
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Add Product")
                                .font(.system(size: 18).bold())
                            Spacer()
                        }
                        VStack(alignment: .leading) {
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
                                        .font(.system(size: 16.75).bold())
                                    
                                    Text(merchandise.offers.primary.productRegularPrice)
                                        .font(.system(size: 17))
                                }
                            }
                            if merchandise.offers.primary.activeSale {
                                Text("This product has an active sale. Adding this product to your shopping list will only show its retail price.")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            Stepper(value: $quantity, in: 1...10) {
                               Text("Quantity (\(quantity))")
                                    .font(.system(size: 15))
                            }
                        }
                    }
                    .padding()
                    Spacer()
                    Divider()
                    VStack {
                        Button {
                            prepareMerchandise()
                        } label: {
                            Text("Save")
                                .padding()
                                .frame(width: UIScreen.main.bounds.width-20)
                                .background(.red)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                            
                        }
                    }
                    .padding()
                }
                .alert("Failed to save", isPresented: $alertOfErrorToSave) {
                    Button("OK") {
                        dismiss()
                    }
                } message: {
                    Text("That item could not be saved to your shopping list. Perhaps try again at a later time?")
                }
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



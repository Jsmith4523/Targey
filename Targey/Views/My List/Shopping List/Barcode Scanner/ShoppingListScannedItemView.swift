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
    
    let merchandise: Merchandise?
    
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


struct Previews_ShoppingListScannedItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListScannedItemView(merchandise: .init(position: 0, product: .init(title: "Coolgate Tooth Paste", link: "", tcin: "123-456-789", dpci: "32442", upc: "", feature_bullets: ["This is toothpaste. I don't know what else to say"], rating: 0.5, rating_total: 0, main_image: "https://www.colgate.com/content/dam/cp-sites/oral-care/oral-care-center-relaunch/en-us/products/toothbrush/colgate-kd-minions-battery-tb.png?size=thumbnail", images: nil), offers: .init(primary: .init(price: 34.32, symbol: "$", regular_price: 3.43))), searchModel: SearchViewModel(), shoppingLM: ShoppingListViewModel())
    }
}

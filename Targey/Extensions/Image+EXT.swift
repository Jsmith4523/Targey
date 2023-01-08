//
//  Image+EXT.swift
//  Targey
//
//  Created by Jaylen Smith on 12/21/22.
//

import Foundation
import SwiftUI

extension Image {
    
    static let placeholderProductImage = Image("placeholder-productImage")
    static let dogOne                  = Image("dog-one")
    static let dogTwo                  = Image("dog-two")
    static let dogBag                  = Image("dog-bag")
    static let cartwheel               = Image("cartwheel")
    static let store                   = Image("store")
    static let homeStore               = Image("home-store")
    static let phoneuser               = Image("phone-user")

    
    func productImageStyle() -> some View {
        return self
            .resizable()
            .scaledToFill()
            .frame(width: 350, height: 350)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .shadow(radius: 5)
    }
    
    ///This can be applied to be dogOne and dogTwo
    func dogSymbolStyle() -> some View {
        return self
            .resizable()
            .scaledToFit()
            .frame(width: 125, height: 125)
            .padding()
    }
    
    func cartwheelSymbolStyle() -> some View {
        return self
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
    }
    
    func barcodeScannerTopButtonsStyle() -> some View {
        return self
            .resizable()
            .scaledToFit()
            .frame(width: 15, height: 15)
            .foregroundColor(.white)
            .padding()
            .background(.white.opacity(0.25))
            .clipShape(Circle())
    }
    
    ///For the main product picture of merchandise retrieved from the server and show in search results
    func mainProductImageStyle() -> some View {
        return self
            .resizable()
            .scaledToFill()
            .frame(width: 115, height: 115)
            .cornerRadius(5)
    }
    
    func shoppingListSelectionOptionButtonStyle() -> some View {
        return self
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(Circle())
            .foregroundColor(.targetRed)
    }
}

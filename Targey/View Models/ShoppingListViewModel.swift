//
//  ShoppingListViewModel.swift
//  Targey
//
//  Created by Jaylen Smith on 12/30/22.
//

import Foundation
import CoreData
import UIKit
import SwiftUI

protocol ShoppingListDelegate {
    func didSelectMerchandise(_ merchandise: Merchandise)
}

final class ShoppingListViewModel: ObservableObject, ShoppingListDelegate {
    
    @Published var shoppingItems = [ShoppingItem]()
    
    @Published var alertErrorOfSavingItem = false
    @Published var alertErrorReason = ""
    
    private let manager = ShoppingListManager.shared
    
    func didSelectMerchandise(_ merchandise: Merchandise) {
        addItemToShoppingList(merchandise)
    }
    
    func addItemToShoppingList(_ merchandise: Merchandise) {
        let feedback = UINotificationFeedbackGenerator()
                
        let shoppingItem      = ShoppingItem(context: manager.container.viewContext)
        shoppingItem.name     = merchandise.product.title
        shoppingItem.imgData  = merchandise.product.mainProductImageURL
        shoppingItem.isOnSale = merchandise.offers.primary.activeSale
        shoppingItem.price    = merchandise.offers.primary.productRegularPrice
        shoppingItem.quantity = 1
        
        manager.save { result in
            switch result {
            case .success(_):
                feedback.notificationOccurred(.success)
                self.fetchItemsFromList()
            case .failure(let reason):
                feedback.notificationOccurred(.error)
                self.alertErrorOfSavingItem.toggle()
                self.alertErrorReason = reason.localizedDescription
            }
        }
    }
        
    func removeItemFromShoppingList(_ shoppingItem: ShoppingItem) {
        manager.remove(shoppingItem)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            self.fetchItemsFromList()
        }
    }
    
    func fetchItemsFromList() {
        withAnimation {
            self.shoppingItems = manager.fetch()
        }
    }
}

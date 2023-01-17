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
    
    @Published var isShowingSearchView = false
    @Published var isShowingScannerView = false
    @Published var isShowingManualView = false
        
    private let manager = ShoppingListManager.shared
    
    func didSelectMerchandise(_ merchandise: Merchandise) {
        addItemToShoppingList(merchandise) { _ in
            
        }
    }
    
    func addItemToShoppingList(_ merchandise: Merchandise, quantity: Int = 1, completion: @escaping (Bool) -> Void) {
        let feedback = UINotificationFeedbackGenerator()
        
        let shoppingItem      = ShoppingItem(context: manager.container.viewContext)
        
        shoppingItem.name     = merchandise.product.title
        shoppingItem.imgData  = merchandise.product.mainProductImageURL ?? nil
        shoppingItem.isOnSale = merchandise.offers.primary.activeSale
        shoppingItem.price    = merchandise.offers.primary.productPriceValue
        shoppingItem.quantity = Int64(quantity)
        shoppingItem.dpci     = merchandise.product.productDcip
        shoppingItem.tcin     = merchandise.product.productTcin
        
        manager.save { result in
            switch result {
            case .success(_):
                feedback.notificationOccurred(.success)
                self.fetchItemsFromList()
                completion(true)
            case .failure(let reason):
                feedback.notificationOccurred(.error)
                self.alertErrorOfSavingItem.toggle()
                self.alertErrorReason = reason.localizedDescription
                completion(false)
            }
        }
    }

    func removeItemFromShoppingList(_ shoppingItem: ShoppingItem) {
        manager.removeItem(shoppingItem)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            self.fetchItemsFromList()
        }
    }
    
    func removeAllItemsFromShoppingList() {
        manager.removeAll()
        self.shoppingItems = []
    }
    
    func fetchItemsFromList() {
        withAnimation {
            self.shoppingItems = manager.fetch()
        }
    }
}

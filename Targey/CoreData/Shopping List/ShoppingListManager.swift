//
//  ShoppingList.swift
//  Targey
//
//  Created by Jaylen Smith on 12/23/22.
//

import Foundation
import CoreData
import UIKit

enum SaveError: Error {
    case error(String)
}

class ShoppingListManager {
    
    let container: NSPersistentContainer
    
    static let shared = ShoppingListManager()
    
    init() {
        container = NSPersistentContainer(name: "ShoppingList")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error initializing Shopping List Store: \(error.localizedDescription)")
            }
        }
    }
    
    func save(completion: @escaping (Result<Bool, SaveError>) -> Void) {
        do {
            try container.viewContext.save()
            completion(.success(true))
        } catch {
            completion(.failure(.error("We had a problem saving that item. Please try again")))
        }
    }
    
    func remove(_ shoppingItem: ShoppingItem) {
        container.viewContext.delete(shoppingItem)
    }
    
    func fetch() -> [ShoppingItem] {
        let request: NSFetchRequest<ShoppingItem> = ShoppingItem.fetchRequest()
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            return []
        }
    }
}

//
//  SearchRequestManager.swift
//  Targey
//
//  Created by Jaylen Smith on 1/7/23.
//

import Foundation
import CoreData


class SearchRequestManager {
    
    let container: NSPersistentContainer
    
    static let shared = ShoppingListManager()
    
    init() {
        container = NSPersistentContainer(name: "ShoppingList")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error initializing: \(error.localizedDescription)")
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

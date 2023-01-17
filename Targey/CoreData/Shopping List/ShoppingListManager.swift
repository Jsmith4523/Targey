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

enum RemoveError: Error {
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
    
    ///Saves uncommited changes in CoreData model
    func save(completion: @escaping (Result<Bool, SaveError>) throws -> Void) {
        do {
            try container.viewContext.save()
            try completion(.success(true))
        } catch {
            print("Unable to changes changes made to context. Rolling back to previous changes...")
            container.viewContext.rollback()
            do {
                try completion(.failure(.error("We had a problem completing that request. Please try again")))
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    ///Remove item passed through the argument from CoreData
    func removeItem(_ shoppingItem: ShoppingItem) {
        container.viewContext.delete(shoppingItem)
        
        do {
            try container.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    ///A User has selected items to be removedFromC
    func checkOffCollectedItems(_ items: Set<ShoppingItem>) throws {
        let generator = UINotificationFeedbackGenerator()
        
        items.forEach { item in
            container.viewContext.delete(item)
        }
        
        do {
            try container.viewContext.save()
            save { status in
                switch status {
                case .success(_):
                    generator.notificationOccurred(.success)
                case .failure(_):
                    generator.notificationOccurred(.error)
                    throw RemoveError.error("There was a problem removing items from your list")
                }
            }
        } catch {
            throw RemoveError.error("There was a problem removing items from your list")
        }
    }
    
    ///Remove all items from CoreData model
    func removeAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ShoppingItem")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
           try container.viewContext.execute(deleteRequest)
        } catch {
            print(error.localizedDescription)
        }
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

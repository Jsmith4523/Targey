//
//  ShoppingListItem.swift
//  Targey
//
//  Created by Jaylen Smith on 12/30/22.
//

import Foundation
import CoreData

struct ShoppingListItem: Identifiable {
    var id = UUID()
    var didFind: Bool = false
    var quantity: Int = 1
    let merchandise: Merchandise
}

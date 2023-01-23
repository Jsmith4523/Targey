//
//  NearestModel.swift
//  Targey
//
//  Created by Jaylen Smith on 1/23/23.
//

import Foundation
import SwiftUI

final class NearestStoreModel: ObservableObject {
    
    @Published var store: Store?
    
    private let stockManager = StoreStockManager()
    private let locationManager = LocationServicesManager()
    
    init() {
        print("I'm created as well")
    }

    func fetchNearestStoreWithStock(_ merchandise: Merchandise) {
        locationManager.getUserZipcode { zipcode in
            self.stockManager.checkStock(tcin: merchandise.product.productTcin, zipcode: zipcode) { status in
                switch status {
                case .success(let stores):
                    if let store = stores.filter({$0.inStock}).first {
                        self.store = store
                    }
                    break
                case .failure(let reason):
                    print("❌ Unable to find one nearby store for merchandise: \(merchandise.product.title)\nREASON: \(reason.localizedDescription)")
                    break
                }
            }
        }
    }
}

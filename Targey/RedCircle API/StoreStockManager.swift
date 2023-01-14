//
//  StoreStockManager.swift
//  Targey
//
//  Created by Jaylen Smith on 12/22/22.
//

import Foundation

enum StoreStockError: Error {
    case error(String)
}

class StoreStockManager: RedCircle {
    
    override init(resourceName: String = "Keys") {
        super.init(resourceName: resourceName)
    }
    
    func checkStock(tcin: String, zipcode: String, withCompletion: @escaping (Result<[Store], StoreStockError>) -> Void) {
        guard let url = URL.fetchStock(tcin: tcin, zipcode: zipcode) else {
            withCompletion(.failure(.error("Bad url")))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let data = data else {
                withCompletion(.failure(.error("Decode error")))
                return
            }
            
            let decoded = try? JSONDecoder().decode(StoreResponse.self, from: data)
            
            if let stores = decoded {
                withCompletion(.success(stores.store_stock_results))
            } else {
                withCompletion(.failure(.error("Decode error")))
            }
        }.resume()
    }
}

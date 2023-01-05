//
//  SearchManager.swift
//  Targey
//
//  Created by Jaylen Smith on 12/21/22.
//

import Foundation

enum FetchError: String, Error {
    case decodeError = "There was an error searching for that product!"
    case badURL      = "The URL given is bad!"
    case fetchError  = "We were unable to communicate with the server!"
}

class SearchManager: RedCircle {
    
    override init(resourceName: String = "Keys") {
        super.init(resourceName: resourceName)
    }
    
    func fetchProducts(term: String, completion: @escaping (Result<[Merchandise], FetchError>) -> Void) {
        
        let connectedTerm = term.replacingOccurrences(of: " ", with: "+")
                
        guard let url = URL.searchURL(term: connectedTerm) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.fetchError))
                return
            }
            
            let response = try? JSONDecoder().decode(MerchandiseResponse.self, from: data)
        
            if let response = response {
                completion(.success(response.search_results))
            } else {
                completion(.failure(.decodeError))
            }
        }.resume()
    }
    
    func fetchProductByTcin(tcin: String, completion: @escaping (Result<ScannedProduct, FetchError>) -> Void) {
        
        guard let url = URL.searchProductbyUPC(tcin: tcin, zipcode: "") else {
            completion(.failure(.badURL))
            return
        }
        
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.decodeError))
                return
            }
            
            let response = try? JSONDecoder().decode(ScannedProductSource.self, from: data)
            
            if let product = response {
                completion(.success(product.product))
            } else {
                completion(.failure(.decodeError))
            }
        }.resume()
    }
}


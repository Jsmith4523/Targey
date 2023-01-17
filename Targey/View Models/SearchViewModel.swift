//
//  SearchViewModel.swift
//  Targey
//
//  Created by Jaylen Smith on 12/21/22.
//

import Foundation

enum LocateStoresError: String, Error {
    case statusError = "Check your location services settings and enable location for Targey"
    case noStoresError = "We were unable to locate any stores with that item!"
}

final class SearchViewModel: ObservableObject, BarcodeScannerDelegate, UserZipCodeDelegate {
    
    @Published var isShowingScannedProductView = false
    @Published var isFindingScannedProduct = false
    @Published var alertOfFailureToFindItem = false

    @Published var isSearching = false
    @Published var didFailToSearch = false
    
    @Published var zipcode = ""
    
    @Published var scannedUpc = ""
    
    @Published var merchandises = [Merchandise]()
    @Published var stores = [Store]()
    @Published var scannedMerchandise: Merchandise?
        
    var locationManager: LocationServicesManager?
    private let searchManager     = SearchManager()
    private let stockStockManager = StoreStockManager()
        
    init(locationManager: LocationServicesManager? = nil) {
        self.locationManager = locationManager
    }
    
    func fetchForProducts(term: String) {
        self.isSearching = true
        self.didFailToSearch = false
        
        searchManager.fetchProducts(term: term) { status in
            switch status {
            case .success(let merchandises):
                DispatchQueue.main.async {
                    self.isSearching = false
                    self.didFailToSearch = false
                    self.merchandises = merchandises
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    self.isSearching = false
                    self.didFailToSearch = true
                }
                print(failure.rawValue)
            }
        }
    }
    
    func suspendCurrentSearchTask() {
        Task {
            await searchManager.suspendTask()
        }
    }
    
    func didRecieveUserZipCode(_ zipcode: String) {
        self.zipcode = zipcode
    }
    
    func locateStoresWithStock(tcin: String, completion: @escaping ((Result<[Store], LocateStoresError>) -> Void)) {
        guard let status = locationManager?.status else {
            completion(.failure(.statusError))
            return
        }
                
        if (status == .authorizedWhenInUse || status == .authorizedAlways) {
            locationManager?.getUserZipcode { zipcode in
                self.stockStockManager.checkStock(tcin: tcin, zipcode: zipcode) { results in
                    switch results {
                    case .success(let stores):
                        completion(.success(stores))
                    case .failure(_):
                        completion(.failure(.noStoresError))
                    }
                }
            }
        }
    }
    
    func didRecieveBarcodeObjectString(_ barcode: String) {
        self.isShowingScannedProductView.toggle()
        self.scannedUpc = barcode
        self.isFindingScannedProduct = true
        
        searchManager.fetchProductByTcin(tcin: barcode) { status in
            switch status {
            case .success(let scannedProduct):
                DispatchQueue.main.async {
                    self.scannedMerchandise = .init(position: 0, product:
                            .init(title: scannedProduct.title,
                                  link: scannedProduct.link,
                                  tcin: scannedProduct.dpci,
                                  dpci: scannedProduct.dpci,
                                  upc: scannedProduct.productUpc,
                                  feature_bullets: scannedProduct.productFeatureBullets,
                                  rating: scannedProduct.rating,
                                  rating_total: nil,
                                  main_image: scannedProduct.main_image?.link,
                                  images: scannedProduct.productImages), offers:
                            .init(primary:
                                    .init(price: scannedProduct.buybox_winner.price?.value,
                                          symbol: "$", regular_price:
                                            scannedProduct.buybox_winner.was_price?.value
                                         )))
                    self.isFindingScannedProduct = false
                }
            case .failure(let reason):
                DispatchQueue.main.async {
                    self.alertOfFailureToFindItem.toggle()
                }
                print(reason.rawValue)
            }
        }
    }
}

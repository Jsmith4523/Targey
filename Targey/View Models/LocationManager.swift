//
//  LocationManager.swift
//  Targey
//
//  Created by Jaylen Smith on 12/23/22.
//

import Foundation
import MapKit
import SwiftUI

protocol UserZipCodeDelegate: AnyObject {
    func didRecieveUserZipCode(_ zipcode: String)
}

enum NearybyStoreError: String, Error {
    case userLocation   = "We ran into a problem locating you"
    case storeLocate    = "We had some problems locating nearby stores"
    case error          = "An error occured when checking for stores!"
}

class LocationServicesManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    weak var userZipCode: UserZipCodeDelegate?
    
    let manager = CLLocationManager()
    
    @Published var status: CLAuthorizationStatus?
    @Published var alertFailedToSaveStore = false
    
    @Published var isShowingSelectNearbyStoreView = false
    @Published var isShowNearbyStoreView = false
    @Published var isShowingSelectedStoreView = false
    
    ///The users favorite store
    @Published var favoriteStore: NearbyStore?
        
    override init() {
        super.init()
        
        manager.delegate = self
        self.fetchFavoriteSavedStore()

    }
    
    func setDelegate(userZipCode: UserZipCodeDelegate) {
        self.userZipCode = userZipCode
    }

    func saveFavoriteNearbyStore(_ store: NearbyStore, completion: @escaping (Bool) -> Void) {
        let encoder = JSONEncoder()
        
        if let storeEncoded = try? encoder.encode(store) {
            print("Store \(store.name) saved")
            UserDefaults.standard.set(storeEncoded, forKey: "favoriteStore")
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            
            favoriteStore = store
            
            completion(true)
        } else {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            completion(false)
        }
    }

    ///Use only when selecting a new store to favorite
    func locateNearbyStoresToFavorite(completion: @escaping (Result<[NearbyStore], NearybyStoreError>) -> Void) {
        var stores = [NearbyStore]()
        let request = MKLocalSearch.Request()
        
        guard let lat = manager.location?.coordinate.latitude, let lon = manager.location?.coordinate.longitude else {
            completion(.failure(.userLocation))
            return
        }
        
        request.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: lat,
                longitude: lon
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 10,
                longitudeDelta: 10
            )
        )
        request.naturalLanguageQuery = "Target"
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response, error == nil else {
                completion(.failure(.storeLocate))
                return
            }
            
            response.mapItems.forEach {
                guard let city = $0.placemark.addressDictionary?["City"] as? String else {
                    completion(.failure(.error))
                    return
                }
                
                let store = NearbyStore(name: city, address: $0.placemark.title ?? "", lat: $0.placemark.location?.coordinate.latitude ?? 0, lon: $0.placemark.location?.coordinate.longitude ?? 0)
                stores.append(store)
            }
            completion(.success(stores))
        }
    }
    
    func getUserZipcode(completion: @escaping (String) -> Void) {        
        guard let location = manager.location else {
            completion("")
            return
        }
        
        CLGeocoder().reverseGeocodeLocation(location) { marks, err in
            guard err == nil else {
                completion("")
                return
            }
            
            if let marks = marks, let postalCode = marks.first?.postalCode {
                completion(postalCode)
            }
        }
    }
    
    private func fetchFavoriteSavedStore() {
        if let favoriteStore = UserDefaults.standard.data(forKey: "favoriteStore") {
            if let decodedStore = try? JSONDecoder().decode(NearbyStore.self, from: favoriteStore) {
                self.favoriteStore = decodedStore
            }
        } else {
            self.favoriteStore = nil
        }
    }
    
    func removeFavoriteStore() {
        UserDefaults.standard.removeObject(forKey: "favoriteStore")
        fetchFavoriteSavedStore()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        getUserZipcode { zipcode in
            self.userZipCode?.didRecieveUserZipCode(zipcode)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.status = manager.authorizationStatus
    }
    
    deinit {
        manager.stopUpdatingLocation()
    }
}

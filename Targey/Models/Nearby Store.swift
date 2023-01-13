//
//  NearbyStore.swift
//  Targey
//
//  Created by Jaylen Smith on 12/25/22.
//

import Foundation
import MapKit

///Only use for retrieving neabry store through MKPointOfInterest; use 'Store' for RedCircle stock API call
struct NearbyStore: Identifiable, Comparable, Codable {
    var id = UUID()
    var name: String
    var address: String
    var lat: Double
    var lon: Double
    
    
    static func > (lhs: NearbyStore, rhs: NearbyStore) -> Bool {
        lhs.name > rhs.name
    }
    static func < (lhs: NearbyStore, rhs: NearbyStore) -> Bool {
        lhs.name < rhs.name
    }
    static func == (lhs: NearbyStore, rhs: NearbyStore) -> Bool {
        return false
    }
}

extension NearbyStore {
    
    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}

//
//  MyStoreInformationView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/13/23.
//

import SwiftUI
import MapKit

struct MyStoreInformationView: View {
    
    let favoriteStore: NearbyStore
    
    @ObservedObject var locationM: LocationServicesManager
    
    @State private var alertToRemoveStore = false
    
    @State private var mapRegion = MKCoordinateRegion()
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $mapRegion, annotationItems: [favoriteStore]) {
                MapAnnotation(coordinate: $0.coordinates) {
                    Annotation()
                }
            }
            .frame(height: 150)
            .disabled(true)
            
            Spacer()
        }
        .navigationTitle("My Store")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Remove") {
                alertToRemoveStore.toggle()
            }
        }
        .confirmationDialog("Remove store?", isPresented: $alertToRemoveStore, actions: {
            Button("Remove", role: .destructive) {
                locationM.removeFavoriteStore()
            }
            Button("Cancel") {}
        }, message: {
            Text("You can always add it back later!")
        })
        .onChange(of: favoriteStore) {
            mapRegion = MKCoordinateRegion(center: $0.coordinates, span: .init(latitudeDelta: 0.008, longitudeDelta: 0.008))
        }
    }
}

struct MyStoreInformationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MyStoreInformationView(favoriteStore: NearbyStore(name: "Hyattsville", address: "3500 East-West Hwy, Unit 1200, Hyattsville, MD 20782, United States", lat: 38.96857863983109, lon: -76.95823650290829), locationM: LocationServicesManager())
        }
    }
}

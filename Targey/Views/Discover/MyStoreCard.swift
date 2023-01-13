//
//  MyStoreInformationView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/13/23.
//

import Foundation
import SwiftUI
import MapKit

struct MyStoreCard: View {
    
    let favoriteStore: NearbyStore
    
    @State private var navigateToStoreView = false
    
    @State private var mapRegion = MKCoordinateRegion()
    
    @ObservedObject var locationM: LocationServicesManager
    
    var body: some View {
        VStack(spacing: 0) {
            Map(coordinateRegion: $mapRegion, annotationItems: [favoriteStore]) {
                MapAnnotation(coordinate: $0.coordinates) {
                    Annotation()
                }
            }
            .frame(height: 150)
            .disabled(false)
            .onTapGesture {
                navigateToStoreView.toggle()
            }
            HStack {
                Image.homeStore
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading, spacing: 2) {
                    Text("My Store")
                        .font(.system(size: 14).bold())
                        .foregroundColor(.green)
                    Text(favoriteStore.name)
                        .font(.system(size: 15))
                    Text(favoriteStore.address)
                        .font(.system(size: 12))
                        .lineLimit(1)
                }
                Spacer()
                Button("Change") {
                    locationM.isShowingSelectNearbyStoreView.toggle()
                }
                .font(.system(size: 14))
                .foregroundColor(.targetRed)
            }
            .padding()
            NavigationLink(isActive: $navigateToStoreView) {
                MyStoreInformationView(favoriteStore: favoriteStore, locationM: locationM)
            } label: {}
        }
        .cornerRadius(18)
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(.gray.opacity(0.2))
        }
        .padding()
        .onChange(of: favoriteStore) {
            mapRegion.center = $0.coordinates
            mapRegion.span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        }
    }
}

struct Previews_MyStoreInformationView_Previews: PreviewProvider {
    static var previews: some View {
        MyStoreCard(favoriteStore: NearbyStore(name: "Hyattsville", address: "3500 East-West Hwy, Unit 1200, Hyattsville, MD 20782, United States", lat: 38.96857863983109, lon: -76.95823650290829), locationM: LocationServicesManager())
    }
}

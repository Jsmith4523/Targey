//
//  SelectedStore.swift
//  Targey
//
//  Created by Jaylen Smith on 12/23/22.
//

import Foundation
import SwiftUI
import MapKit

struct SelectedStoreView: View {
    
    @Binding var selectedStore: NearbyStore?
    
    @ObservedObject var locationManager: LocationServicesManager
    
    @Environment (\.dismiss) var dismiss
    
    var coordinate: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: selectedStore!.lat, longitude: selectedStore!.lon), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Map(coordinateRegion: .constant(coordinate), annotationItems: [selectedStore!], annotationContent: {
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lon)) {
                        Annotation()
                    }
                })
                    .frame(height: 150)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 0.35)
                    }
                    .padding(.horizontal)
                    .disabled(true)
                VStack(alignment: .leading) {
                    Text(selectedStore!.name)
                        .font(.system(size: 25).weight(.semibold))
                    Text(selectedStore!.address)
                        .font(.system(size: 16.5))
                }
                .padding()
                HStack {
                    Button {
                        self.saveFavoriteStore()
                    } label: {
                        Image(systemName: "checkmark")
                            .padding()
                            .foregroundColor(.green)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .padding()
                            .foregroundColor(.targetRed)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .navigationTitle("Confirm")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Error", isPresented: $locationManager.alertFailedToSaveStore) {
                Button("OK") {}
            } message: {
                Text("There was an error saving that store")
            }
        }
        .interactiveDismissDisabled()
    }
    
    private func saveFavoriteStore() {
        locationManager.saveFavoriteNearbyStore(selectedStore!) { isSaved in
            switch isSaved {
            case true:
                dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    locationManager.isShowNearbyStoreView = false
                }
            case false:
                locationManager.alertFailedToSaveStore.toggle()
            }
        }
    }
}

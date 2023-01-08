//
//  SelectFavoriteStoreView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/23/22.
//

import SwiftUI

struct SelectFavoriteStoreView: View {
    
    @State private var nearbyStores = [NearbyStore]()
    
    @State private var alertOfErrorToGetStores = false
    @State private var errorReason = ""
    
    @State private var selectedStore: NearbyStore? {
        didSet {
            locationManager.isShowingSelectedStoreView.toggle()
        }
    }
        
    @ObservedObject var locationManager: LocationServicesManager
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(nearbyStores.sorted(by: <)) { store in
                        Button {
                            selectedStore = store
                        } label: {
                            NearbyStoreCellView(locationManager: locationManager, nearbyStore: store)
                        }
                        Divider()
                    }
                }
            }
            .navigationTitle("Select your Store")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Close") {
                    dismiss()
                }
                .foregroundColor(.targetRed)
            }
        }
        .interactiveDismissDisabled()
        .customSheetView(isPresented: $locationManager.isShowingSelectedStoreView, detents: [.medium()], showsIndicator: false, cornerRadius: 30) {
            SelectedStoreView(selectedStore: $selectedStore, locationManager: locationManager)
            
        }
        .onAppear {
            self.getNearbyStores()
        }
        .alert("Error", isPresented: $alertOfErrorToGetStores) {
            Button("OK") { dismiss() }
        } message: {
            Text(errorReason)
        }
    }
    
    private func getNearbyStores() {
        locationManager.locateNearbyStoresToFavorite { status in
            switch status {
            case .success(let nearbyStores):
                DispatchQueue.main.async {
                    self.nearbyStores = nearbyStores
                }
            case .failure(let reason):
                DispatchQueue.main.async {
                    self.errorReason = reason.rawValue
                    self.alertOfErrorToGetStores.toggle()
                }
            }
        }
    }
    
    struct NearbyStoreCellView: View {
        
        @ObservedObject var locationManager: LocationServicesManager
        
        let nearbyStore: NearbyStore
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(nearbyStore.name)
                        .font(.system(size: 20).weight(.semibold))
                        .lineLimit(1)
                    Text(nearbyStore.address)
                        .font(.system(size: 15))
                        .lineLimit(1)
                }
                Spacer()
                if locationManager.favoriteStore?.address == nearbyStore.address {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.green)
                }
            }
            .accentColor(.reversed)
            .padding()
        }
    }
}

struct SelectFavoriteStoreView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedStoreView(selectedStore: .constant(NearbyStore(name: "College Park", address: "7501 Baltimore Ave, Unit 1, College Park, MD  20740, United States", lat: 38.98219725423894, lon: -76.93747043609619)), locationManager: LocationServicesManager())
    }
}

//CLLocationCoordinate2D(latitude: 38.98219725423894, longitude: -76.93747043609619)

//
//  HomeStoreView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/23/22.
//

import SwiftUI
import MapKit

struct HomeStoreView: View {
        
    @ObservedObject var onboardModel: OnBoardModel
    @ObservedObject var locationManager: LocationServicesManager
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)
            Image("store")
                .storeGlyph()
            Text("Lets find your home store")
                .font(.system(size: 25).bold())
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 40)
            Text("Your home store is the closest store you reside to. Enable Location Services and we will handle it from here")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 35)
            
            VStack {
                if (locationManager.status == .authorizedAlways || locationManager.status == .authorizedWhenInUse) {
                    Button("Show Stores") {
                        locationManager.isShowNearbyStoreView.toggle()
                    }
                    .padding(10)
                } else {
                    Text("Location Servies are disable. Go to Settings>Targey to re-enable them")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(10)
                }
                
                if (locationManager.status != nil) {
                    NavigationLink {
                        ThankYouView(onboardModel: onboardModel)
                    } label: {
                        Text("Next")
                            .foregroundColor(.targetRed)
                    }
                    .padding(10)
                }
                
                Spacer()
                    .frame(height: 25)
                if locationManager.favoriteStore != nil {
                    YourStoreView(locationManager: locationManager)
                }
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $locationManager.isShowNearbyStoreView) {
            SelectFavoriteStoreView(locationManager: locationManager)
        }
        .onAppear {
            locationManager.manager.requestWhenInUseAuthorization()
        }
    }
}

fileprivate struct YourStoreView: View {
    
    @ObservedObject var locationManager: LocationServicesManager
    
    var favoriteStore: NearbyStore {
        locationManager.favoriteStore!
    }
    
    var body: some View {
        VStack {
            Divider()
                .padding(.bottom)
            HStack {
                Image.homeStore
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text(favoriteStore.name)
                        .font(.system(size: 15).bold())
                    Text(favoriteStore.address)
                        .font(.system(size: 13))
                    Text("My Store")
                        .font(.system(size: 13.2))
                        .foregroundColor(.green)
                }
                Spacer()
            }
        }
    }
}

struct HomeStoreView_Previews: PreviewProvider {
        
    static var previews: some View {
        YourStoreView(locationManager: LocationServicesManager())
    }
}

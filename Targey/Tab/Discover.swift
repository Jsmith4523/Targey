//
//  HomeView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/20/22.
//

import SwiftUI

struct DiscoverView: View {
        
    @StateObject private var promotionsModel = PromotionViewModel()
    @StateObject private var locationsModel = LocationServicesManager()
        
    var body: some View {
        NavigationView {
            VStack {
                TopNavigation(locationsModel: locationsModel)
                ScrollView {
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(.targetRed)
        }
        .sheet(isPresented: $locationsModel.isShowingSelectNearbyStoreView) {
            SelectFavoriteStoreView(locationManager: locationsModel)
        }
    }
}

fileprivate struct TopNavigation: View {
    
    @ObservedObject var locationsModel: LocationServicesManager
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Hi, There")
                    .font(.system(size: 20).bold())
                if let favoriteStore = locationsModel.favoriteStore {
                    Button {
                        locationsModel.isShowingSelectNearbyStoreView.toggle()
                    } label: {
                        HStack(spacing: 2) {
                            Text("My Store: \(favoriteStore.name)")
                                .font(.system(size: 13))
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                        }
                        .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal)
            Spacer()
            NavigationLink {
                UserSettingsView()
            } label: {
                Image.dogOne
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65, height: 65)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}

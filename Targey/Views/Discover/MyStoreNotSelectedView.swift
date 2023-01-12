//
//  MyStoreNotSelectedView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/12/23.
//

import Foundation
import SwiftUI

struct MyStoreNotSelectView: View {
    
    @State private var isShowingSelectNearbyStoreView = false
    
    @ObservedObject var locationM: LocationServicesManager
    
    var body: some View {
        HStack {
            Image.homeStore
                .resizable()
                .scaledToFit()
                .frame(width: 65, height: 65)
            VStack(alignment: .leading) {
                Text("Find your Home Store")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 15).bold())
                Text("Easily check and see if items are locally in stock to the store nearest you.")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 11.5))
                Spacer()
                    .frame(height: 5)
                Button("Find Store") {
                    isShowingSelectNearbyStoreView.toggle()
                }
                .font(.system(size: 13).bold())
                .foregroundColor(.targetRed)
            }
            Spacer()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width-50)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .sheet(isPresented: $isShowingSelectNearbyStoreView) {
            SelectFavoriteStoreView(locationManager: locationM)
        }
    }
}

//
//  MyStoreView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/12/23.
//

import SwiftUI
import MapKit

struct MyStoreView: View {
    
    @StateObject private var locationM = LocationServicesManager()
    
    var body: some View {
        ZStack {
            if let favoriteStore = locationM.favoriteStore {
                MyStoreCard(favoriteStore: favoriteStore, locationM: locationM)
            } else {
                MyStoreNotSelectView(locationM: locationM)
            }
        }
    }
}


struct MyStoreView_Previews: PreviewProvider {
    static var previews: some View {
        MyStoreView()
    }
}

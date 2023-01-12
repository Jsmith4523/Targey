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
        if let favoriteStore = locationM.favoriteStore {
            MyStoreInformationView(favoriteStore: favoriteStore)
        } else {
            MyStoreNotSelectView(locationM: locationM)
        }
    }
}

fileprivate struct MyStoreInformationView: View {
    
    let favoriteStore: NearbyStore
    
    var body: some View {
        VStack {
            
        }
    }
}

struct MyStoreView_Previews: PreviewProvider {
    static var previews: some View {
        MyStoreView()
    }
}

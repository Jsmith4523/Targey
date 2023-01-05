//
//  HomeView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/20/22.
//

import SwiftUI

struct DiscoverView: View {
        
    @StateObject private var searchModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            List {
                
            }
            .navigationTitle("Discover")
        }
        .accentColor(.targetRed)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}

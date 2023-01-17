//
//  ContentView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/20/22.
//

import SwiftUI

struct Tab: View {
    var body: some View {
        TabView {
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "takeoutbag.and.cup.and.straw.fill")
                }
            MyList()
                .tabItem {
                    Label("My List", systemImage: "checklist")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
        .accentColor(.targetRed)
    }
}

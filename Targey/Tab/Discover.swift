//
//  HomeView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/20/22.
//

import SwiftUI

struct DiscoverView: View {
        
    @StateObject private var promotionsModel = PromotionViewModel()
        
    var body: some View {
        NavigationView {
            ScrollView {
                Spacer()
                    .frame(height: 5)
                VStack(spacing: 20) {
                    MyStoreView()
                    DiscoverContentSection(header: "Promotions") {
                        PromotionsView()
                    }
                }
            }
            .navigationTitle("Discover")
            .accentColor(.targetRed)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}

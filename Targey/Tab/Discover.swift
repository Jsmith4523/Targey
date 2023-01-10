//
//  HomeView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/20/22.
//

import SwiftUI

struct DiscoverView: View {
        
    @StateObject private var promotionsModel = PromotionViewModel()
    
    let foo: [Promotion] = [
        .init(title: "Be Someomes Valentine's with these latest products", prompt: "Gear up for valentines day by shopping for products before they're gone next month!", searchTerm: "Cookies", bannerImgURL: "https://corporate.target.com/_media/TargetCorp/news/2019/01/valentines/ABV_Valentines_Header.jpg?ext=.jpg")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(foo) { foo in
                    PromotionsCellView(promotion: foo)
                }
                .navigationTitle("Discover")
            }
            .accentColor(.targetRed)
            .onAppear {
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}

//
//  SelectedPromotonResultsVIew.swift
//  Targey
//
//  Created by Jaylen Smith on 1/10/23.
//

import SwiftUI

struct SelectedPromotonResultsView: View {
    
    let promotion: Promotion
    
    @ObservedObject var searchModel: SearchViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                if let imageURL = promotion.bannerURL {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipped()
                    } placeholder: {}
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text(promotion.title)
                        .font(.system(size: 22).bold())
                        .multilineTextAlignment(.leading)
                    Text(promotion.prompt)
                        .font(.system(size: 18))
                        .multilineTextAlignment(.leading)
                }
            }
            .navigationTitle(promotion.searchTerm)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

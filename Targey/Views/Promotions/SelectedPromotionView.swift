//
//  SelectedPromotionResultsView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/10/23.
//

import SwiftUI

struct SelectedPromotionView: View {
    
    let promotion: Promotion
    
    @StateObject private var searchModel = SearchViewModel()
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            switch searchModel.merchandises.isEmpty {
            case true:
                DogProgessView()
            case false:
                SelectedPromotonResultsView(promotion: promotion, searchModel: searchModel)
            }
        }
        .onAppear {
            searchModel.fetchForProducts(term: promotion.searchTerm)
        }
        .alert("Error", isPresented: $searchModel.didFailToSearch) {
            Button("OK") { dismiss() }
        } message: {
            Text("There was an error with this promotion. Please try again later")
        }
    }
}

struct SelectedPromotionResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedPromotionView(promotion: .init(title: "Be Someomes Valentine's with these latest products", prompt: "Gear up for valentines day by shopping for products before they're gone next month!", searchTerm: "Valentines", bannerImgURL: "https://corporate.target.com/_media/TargetCorp/news/2019/01/valentines/ABV_Valentines_Header.jpg?ext=.jpg"))
    }
}

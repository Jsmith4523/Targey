//
//  PromotionsCellView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/10/23.
//

import SwiftUI

struct PromotionsCellView: View {
    
    let promotion: Promotion
    
    var body: some View {
        VStack(alignment: .leading) {
            if let url = promotion.bannerURL {
                withAnimation {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width-45,height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    } placeholder: {}
                }
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(promotion.title)
                    .font(.system(size: 20).bold())
                    .multilineTextAlignment(.leading)
                Text(promotion.prompt)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.leading)
                NavigationLink("Show More") {
                    SelectedPromotionView(promotion: promotion)
                }
                .foregroundColor(.targetRed)
            }
        }
        .padding(.horizontal)
    }
}

struct PromotionsCellView_Previews: PreviewProvider {
    static var previews: some View {
        PromotionsCellView(promotion: .init(title: "Be Someomes Valentine's with these latest products", prompt: "Gear up for valentines day by shopping for products before they're gone next month!", searchTerm: "Valentines", bannerImgURL: "https://corporate.target.com/_media/TargetCorp/news/2019/01/valentines/ABV_Valentines_Header.jpg?ext=.jpg"))
    }
}

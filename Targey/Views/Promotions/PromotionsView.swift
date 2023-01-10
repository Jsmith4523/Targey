//
//  PromotionsView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/10/23.
//

import SwiftUI

struct PromotionsView: View {
    
    @ObservedObject var promotionsModel: PromotionViewModel
    
    var body: some View {
        ScrollView {
            
        }
    }
}

struct PromotionsView_Previews: PreviewProvider {
    static var previews: some View {
        PromotionsView(promotionsModel: PromotionViewModel())
    }
}

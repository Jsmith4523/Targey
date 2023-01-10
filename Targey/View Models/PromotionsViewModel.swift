//
//  PromotionsViewModel.swift
//  Targey
//
//  Created by Jaylen Smith on 1/10/23.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

final class PromotionViewModel: ObservableObject {
    
    @Published var promotions = [Promotion]()
    
}

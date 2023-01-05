//
//  SelectedStoreInStockView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/26/22.
//

import SwiftUI
import MapKit

struct SelectedStoreInStockView: View {
    
    let store: Store
    
    var body: some View {
        VStack {
            
        }
    }
}

struct SelectedStoreInStockView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedStoreInStockView(store: .init(store_name: "Forestville",
                                              store_id: "",
                                              in_stock: true,
                                              stock_level: 14,
                                              address: "3101 Donnel Drive",
                                              city: "Forestville",
                                              state: "MD",
                                              zipcode: "20747",
                                              phone: "301-234-5678",
                                              distance: 3.4))
    }
}

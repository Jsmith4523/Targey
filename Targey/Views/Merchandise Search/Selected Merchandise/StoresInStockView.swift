//
//  StoresInStockView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/24/22.
//

import SwiftUI

struct StoresInStockView: View {
    
    @State private var alertOfError = false
    @State private var erroReason = "There was an error"
    
    @State private var stores = [Store]()
    
    let merchandise: Merchandise
    
    var product: product {
        merchandise.product
    }
    
    @StateObject private var locationManager = LocationServicesManager()
    @StateObject private var searchModel = SearchViewModel()
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(stores.filter({$0.inStock == true}), id: \.store_id){ store in
                    FetchedStoreView(store: store, searchModel: searchModel)
                    Divider()
                }
                ForEach(stores.filter({$0.inStock == false}), id: \.store_id){ store in
                    FetchedStoreView(store: store, searchModel: searchModel)
                    Divider()
                }
            }
            .navigationTitle("In Stock")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Close") {
                    dismiss()
                }
            }
            .accentColor(.targetRed)
        }
        .alert("Error", isPresented: $alertOfError, actions: {
            Button("Retry") {
                fetchStoresWithProduct()
            }
            Button("OK") { dismiss() }
        }, message: {
            Text(erroReason)
        })
        .onAppear {
            locationManager.manager.startUpdatingLocation()
            searchModel.locationManager = locationManager
            locationManager.setDelegate(userZipCode: searchModel)
        }
        .onChange(of: searchModel.zipcode) { _ in
            fetchStoresWithProduct()
        }
    }
    
    private func fetchStoresWithProduct() {
        searchModel.locateStoresWithStock(tcin: product.productTcin) { response in
            switch response {
            case .success(let stores):
                DispatchQueue.main.async {
                    self.stores = stores
                }
            case .failure(let reason):
                DispatchQueue.main.async {
                    self.erroReason = reason.rawValue
                    self.alertOfError.toggle()
                }
            }
        }
    }
}

fileprivate struct FetchedStoreView: View {
    
    let store: Store
    
    @ObservedObject var searchModel: SearchViewModel
    
    var stockText: Text {
        
        var stock: Text {
            return Text(store.stockLevel)
                .foregroundColor(.reversed)
        }
        
        var instockText: Text {
            return Text("In Stock: ")
                .foregroundColor(.green)
        }
        
        if store.inStock {
            return instockText+stock
        } else {
            return Text("Out of Stock")
                .foregroundColor(.orange)
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(store.storeName)
                    .font(.system(size: 17.5).weight(.semibold))
                stockText
                    .font(.system(size: 15))
                Text("\(store.storeDistance) miles away")
                    .font(.system(size: 13.5))
            }
            Spacer()
            NavigationLink {
                
            } label: {
                Image(systemName: "info.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .padding()
    }
}

struct StoresInStockView_Previews: PreviewProvider {
    static var previews: some View {
        StoresInStockView(merchandise: .init(position: 1, product: .init(title: "", link: "", tcin: "", dpci: "", feature_bullets: [""], rating: nil, rating_total: 0, main_image: "", images: [""]), offers: .init(primary: .init(price: 0, symbol: "", regular_price: nil))))
    }
}

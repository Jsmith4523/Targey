//
//  ShoppingListBarcodeScannerView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/7/23.
//

import SwiftUI

struct ShoppingListBarcodeScannerView: View {
    
    @State private var isShowingManualEntryView = false
    
    @StateObject private var cameraModel = CameraModel()
    @StateObject private var searchModel = SearchViewModel()
    @ObservedObject var shopLM: ShoppingListViewModel
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            BarcodeScannerOutputView(cameraModel: cameraModel)
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                Spacer()
            }
        }
        .autocorrectionDisabled(true)
        .alert("Product Not Found", isPresented: $searchModel.alertOfFailureToFindItem, actions: {
            Button("Yes"){ isShowingManualEntryView.toggle() }
            Button("Cancel"){}
        }, message: {
            Text("We couldn't find that product within the Target Database! Would you like to manually enter the product?")
        })
        .sheet(isPresented: $isShowingManualEntryView) {
            ShoppingListManualEnterView(shopLM: shopLM, scannedUpc: searchModel.scannedUpc)
        }
        .onAppear {
            cameraModel.setDelegate(barcodeDelegate: searchModel)
            cameraModel.beginSetup()
        }
    }
}

struct ShoppingListBarcodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListBarcodeScannerView(shopLM: ShoppingListViewModel())
    }
}

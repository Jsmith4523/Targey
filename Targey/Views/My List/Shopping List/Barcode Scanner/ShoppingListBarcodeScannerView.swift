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
    @Environment (\.colorScheme) var deviceColorScheme
    
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
        .statusBar(hidden: true)
        .sheet(isPresented: $isShowingManualEntryView) {
            ShoppingListManualEnterView(shopLM: shopLM, scannedUpc: searchModel.scannedUpc)
        }
        .customSheetView(isPresented: $searchModel.isShowingScannedProductView, detents: [.medium()], showsIndicator: true, cornerRadius: 15) {
            ShoppingListSearchedItemView(merchandise: $searchModel.scannedMerchandise,searchModel: searchModel, shoppingLM: shopLM)
                .onDisappear {
                    cameraModel.relaunchSesson()
                }
        }
        .onAppear {
            cameraModel.setDelegate(barcodeDelegate: searchModel)
            cameraModel.beginSetup()
        }
        .onDisappear {
//            print(deviceColorScheme)
//            colorScheme = deviceColorScheme
        }
    }
}

struct ShoppingListBarcodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListBarcodeScannerView(shopLM: ShoppingListViewModel())
    }
}

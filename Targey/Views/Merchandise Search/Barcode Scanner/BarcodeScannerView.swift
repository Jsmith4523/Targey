//
//  BarcodeScannerView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/25/22.
//

import SwiftUI

struct BarcodeScannerView: View {
    
    @State private var isShowingSelectedMerchandiseView = false
    
    @State private var colorScheme: ColorScheme = .dark
    
    @StateObject private var cameraModel = CameraModel()
    @StateObject private var searchModel = SearchViewModel()
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                BarcodeScannerOutputView(cameraModel: cameraModel)
                BarcodeScannerBottomInstructionsView(cameraModel: cameraModel, searchModel: searchModel)
            }
        }
        .accentColor(.targetRed)
        .preferredColorScheme(colorScheme)
        .customSheetView(isPresented: $searchModel.isShowingScannedProductView, detents: [.medium()], showsIndicator: true, cornerRadius: 15) {
            ScannedProductView(isShowingSelectedProductView: $isShowingSelectedMerchandiseView, cameraModel: cameraModel, searchModel: searchModel)
        }
        .onAppear {
           cameraModel.setDelegate(barcodeDelegate: searchModel)
           cameraModel.beginSetup()
        }
        .onDisappear {
            cameraModel.session.stopRunning()
        }
        .onChange(of: isShowingSelectedMerchandiseView) { _ in
            colorScheme = .light
        }
    }
}

struct BarcodeScannerBottomInstructionsView: View {
    
    @ObservedObject var cameraModel: CameraModel
    @ObservedObject var searchModel: SearchViewModel
    
    var body: some View {
        VStack {
            Text(searchModel.isSearching ? "Searching..." : "Positon barcode within frame")
                .font(.system(size: 20).bold())
            
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(30)
        .padding()
    }
}

struct BarcodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
            .preferredColorScheme(.dark)
    }
}

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
            ZStack {
                ZStack(alignment: .bottom) {
                    BarcodeScannerOutputView(cameraModel: cameraModel)
                    LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                        .frame(height: 350)
                }
                .ignoresSafeArea()
                VStack(spacing: 10) {
                    HStack {
                        Spacer()
                        if cameraModel.deviceHasTorch {
                            Button {
                                cameraModel.toggleTorch()
                            } label: {
                                Image(systemName: cameraModel.torchIsOn ? "bolt.fill" : "bolt")
                                    .barcodeScannerTopButtonsStyle()
                            }
                        }
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .barcodeScannerTopButtonsStyle()
                        }
                    }
                    Spacer()
                    Text(searchModel.isFindingScannedProduct ? "Finding item... This may take a few" : "Place a barcode within the rectangle")
                        .foregroundColor(.white)
                        .font(.system(size: 20).weight(.semibold))
                    Text("Most items may not be recognize.")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                    if !(searchModel.scannedMerchandise == nil) {
                        NavigationLink(isActive: $isShowingSelectedMerchandiseView) {
                            SelectedMerchandiseView(merchandise: searchModel.scannedMerchandise!, searchModel: searchModel)
                                .onDisappear {
                                    colorScheme = .dark
                                    cameraModel.relaunchSesson()
                                }
                        } label: {}
                    }
                }
                .multilineTextAlignment(.center)
                .padding()
            }
        }
        .accentColor(.targetRed)
        .alert("Error", isPresented: $searchModel.alertOfFailureToFindItem, actions: {
            Button("Ok") {
                cameraModel.relaunchSesson()
            }
        }, message: {
            Text("That product could not be found")
        })
        .preferredColorScheme(colorScheme)
        .customSheetView(isPresented: $searchModel.isShowingScannedProductView, detents: [.medium(), .large()], showsIndicator: true, cornerRadius: 30) {
            ScannedProductView( isShowingSelectedProductView: $isShowingSelectedMerchandiseView, scannerModel: cameraModel, searchModel: searchModel)
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

struct BarcodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
            .preferredColorScheme(.dark)
    }
}

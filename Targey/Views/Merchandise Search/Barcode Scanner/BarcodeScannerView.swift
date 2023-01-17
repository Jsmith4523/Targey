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
                if let merchandise = searchModel.scannedMerchandise {
                    NavigationLink(isActive: $isShowingSelectedMerchandiseView) {
                        SelectedMerchandiseView(merchandise: merchandise, searchModel: searchModel)
                            .onAppear {
                                colorScheme = .light
                            }
                            .onDisappear {
                                cameraModel.relaunchSesson()
                                colorScheme = .dark
                            }
                    } label: {}
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if cameraModel.deviceHasTorch {
                        Button {
                            cameraModel.toggleTorch()
                        } label: {
                            Image(systemName: "flashlight.on.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                                .foregroundColor(.white)
                                .shadow(radius: 3)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.white)
                            .shadow(radius: 3)
                    }
                }
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
    }
}

struct BarcodeScannerBottomInstructionsView: View {
    
    @ObservedObject var cameraModel: CameraModel
    @ObservedObject var searchModel: SearchViewModel
    
    var body: some View {
        VStack {
            Text("Positon barcode within frame")
                .font(.system(size: 20).bold())
                .foregroundColor(.white)
                .shadow(radius: 7)
        }
        .padding()
    }
}

struct BarcodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
            .preferredColorScheme(.dark)
    }
}

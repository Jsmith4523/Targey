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
    
    @State private var recWidth: CGFloat = UIScreen.main.bounds.width-100
    @State private var recHeight: CGFloat = 200
    
    @StateObject private var barcodeModel = CameraModel()
    @StateObject private var searchModel = SearchViewModel()
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack(alignment: .bottom) {
                   CameraSession(cameraModel: barcodeModel)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.white)
                                .frame(width: recWidth, height: recHeight)
                        }
                    LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                        .frame(height: 350)
                }
                .ignoresSafeArea()
                VStack(spacing: 10) {
                    HStack {
                        Spacer()
                        if barcodeModel.deviceHasTorch {
                            Button {
                                barcodeModel.toggleTorch()
                            } label: {
                                Image(systemName: barcodeModel.torchIsOn ? "bolt.fill" : "bolt")
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
                    NavigationLink(isActive: $isShowingSelectedMerchandiseView) {
                        SelectedMerchandiseView(merchandise: searchModel.scannedMerchandise!, searchModel: searchModel)
                            .onDisappear {
                                colorScheme = .dark
                                barcodeModel.relaunchSesson()
                            }
                    } label: {}
                }
                .multilineTextAlignment(.center)
                .padding()
            }
        }
        .accentColor(.targetRed)
        .alert("Error", isPresented: $searchModel.alertOfFailureToFindItem, actions: {
            Button("Ok") {
                barcodeModel.relaunchSesson()
            }
        }, message: {
            Text("That product could not be found")
        })
        .preferredColorScheme(colorScheme)
        .customSheetView(isPresented: $searchModel.isShowingScannedProductView,
                         child: ScannedProductView(
                            isShowingSelectedProductView: $isShowingSelectedMerchandiseView,
                            scannerModel: barcodeModel,
                            searchModel: searchModel
                         ),
                         detents: [.medium(), .large()],
                         showsIndicator: true,
                         cornerRadius: 30
        )
        .onAppear {
            barcodeModel.setDelegate(barcodeDelegate: searchModel)
            barcodeModel.beginSetup()
        }
        .onDisappear {
            barcodeModel.session.stopRunning()
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

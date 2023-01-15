//
//  ScannedObjectView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/25/22.
//

import SwiftUI

struct ScannedProductView: View {
    
    @State private var shouldNotStartCameraSession = false
    
    @Binding var isShowingSelectedProductView: Bool
    
    @ObservedObject var cameraModel: CameraModel
    @ObservedObject var searchModel: SearchViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var merchandise: Merchandise? {
        searchModel.scannedMerchandise
    }
    
    var body: some View {
        NavigationView {
            if searchModel.isFindingScannedProduct {
                DogProgessView()
            } else {
                if let merchandise = merchandise {
                    MerchandiseScannedProductView(method: self.navigateToProductPage, merchandise: merchandise, searchModel: searchModel)
                } else {
                    ScannedProductNotFoundView()
                }
            }
        }
        .onDisappear {
            if !shouldNotStartCameraSession {
                cameraModel.relaunchSesson()
                cameraModel.stopScanningForObject.toggle()
            }
        }
        .onAppear {
            cameraModel.stopScanningForObject.toggle()
        }
        .alert("Error", isPresented: $searchModel.alertOfFailureToFindItem, actions: {
            Button("Ok") {
                dismiss()
                cameraModel.relaunchSesson()
            }
        }, message: {
            Text("That product could not be found")
        })
    }
    
    func navigateToProductPage() {
        dismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            isShowingSelectedProductView.toggle()
        }
    }
}

fileprivate struct MerchandiseScannedProductView: View {
    
    var method: () -> Void
        
    let merchandise: Merchandise
    
    @ObservedObject var searchModel: SearchViewModel
    
    var body: some View {
        VStack {
            ScannedProductInformationView(merchandise: merchandise, upc: searchModel.scannedUpc)
            Spacer()
            Divider()
            Button {
                method()
            } label: {
                Text("Show More")
                    .padding()
                    .frame(width: UIScreen.main.bounds.width-20)
                    .background(.red)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(.white)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.green)
                    Text("We found it!")
                        .font(.system(size: 17).bold())
                        .foregroundColor(.reversed)
                }
            }
        }
    }
}

fileprivate struct ScannedProductNotFoundView: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("That product couldn't be found")
                .font(.system(size: 20).weight(.semibold))
            Text("Please try again")
                .font(.system(size: 17))
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

struct ScannedObjectView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScannedProductView(isShowingSelectedProductView: .constant(false), cameraModel: CameraModel(), searchModel: SearchViewModel())
                .preferredColorScheme(.dark)
        }
    }
}

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
    
    @ObservedObject var scannerModel: CameraModel
    @ObservedObject var searchModel: SearchViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var merchandise: Merchandise? {
        searchModel.scannedMerchandise
    }

    var body: some View {
        NavigationView {
            VStack {
                if let merchandise = merchandise {
                    VStack {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    AsyncImage(url: merchandise.product.mainProductImageURL!) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    } placeholder: {
                                        Image.placeholderProductImage
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                    VStack(alignment: .leading) {
                                        Text(merchandise.product.title)
                                            .font(.system(size: 17).weight(.semibold))
                                            .multilineTextAlignment(.leading)
                                        HStack {
                                            if merchandise.offers.primary.activeSale {
                                                Text(merchandise.offers.primary.productRegularPrice)
                                                    .strikethrough(merchandise.offers.primary.activeSale, color: .red)
                                                Text(merchandise.offers.primary.productSalePrice)
                                                    .foregroundColor(merchandise.offers.primary.activeSale ? .red : .reversed)
                                            } else {
                                                Text(merchandise.offers.primary.productSalePrice)
                                                    .foregroundColor(.reversed)
                                            }
                                        }
                                    }
                                    Spacer()
                                }
                                VStack(alignment: .leading, spacing: 1.5) {
                                    ForEach( merchandise.product.productBullets, id: \.self) { bullet in
                                        Text(bullet)
                                            .font(.system(size: 16))
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                        }
                        VStack {
                            Divider()
                            Button {
                                shouldNotStartCameraSession = true
                                dismiss()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    isShowingSelectedProductView.toggle()
                                }
                            } label: {
                                Text("More Details")
                                    .padding()
                                    .frame(width: UIScreen.main.bounds.width-30)
                                    .background(.red)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                            }
                        }
                    }
                } else {
                    ScannedProductNotFoundView()
                }
            }
        }
        .onDisappear {
            if !shouldNotStartCameraSession {
                scannerModel.relaunchSesson()
                scannerModel.stopScanningForObject.toggle()
            }
        }
        .onAppear {
            scannerModel.stopScanningForObject.toggle()
        }
    }
}

struct ScannedProductNotFoundView: View {
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
        ScannedProductView(isShowingSelectedProductView: .constant(false), scannerModel: CameraModel(), searchModel: SearchViewModel())
    }
}

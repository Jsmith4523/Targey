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
            if let merchandise = merchandise {
                ScannedProductInformationView(method: self.navigateToProductPage, merchandise: merchandise, searchModel: searchModel)
            } else {
                ScannedProductNotFoundView()
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
    
    func navigateToProductPage() {
        dismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            isShowingSelectedProductView.toggle()
        }
    }
}

fileprivate struct ScannedProductInformationView: View {
    
    var method: () -> Void
        
    let merchandise: Merchandise
    
    @ObservedObject var searchModel: SearchViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    VStack(alignment: .leading) {
                        HStack {
                            Label {
                                Text("We found it")
                                    .font(.system(size: 17).bold())
                            } icon: {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.green)
                            }
                            Spacer()
                        }
                        HStack(alignment: .top) {
                            AsyncImage(url: merchandise.product.mainProductImageURL!) { img in
                                img
                                    .scannedProductImageStyle()
                            } placeholder: {
                                Image.placeholderProductImage
                                    .scannedProductImageStyle()
                            }
                            VStack(alignment: .leading, spacing: 2) {
                                Text(merchandise.product.title)
                                    .font(.system(size: 15).weight(.medium))
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                ratingView(rating: merchandise.product.productRating, reviewCount: 0)
                                merchandise.offers.primary.productPriceLabel
                                    .font(.system(size: 15))
                            }
                        }
                        .frame(height: 85)
                    }
                    DiscoverContentSection(header: "Details") {
                        ForEach(merchandise.product.productBullets, id: \.self) {
                            Text($0)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 14))
                        }
                    }
                    DiscoverContentSection(header: "Additional Information") {
                        VStack(alignment: .leading) {
                            Text("DPCI: \(merchandise.product.productDcip)")
                            Text("TCIN: \(merchandise.product.productTcin)")
                            Text("UPC: \(searchModel.scannedUpc)")
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    }
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
            }
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
            ScannedProductView(isShowingSelectedProductView: .constant(false), scannerModel: CameraModel(), searchModel: SearchViewModel())
                .preferredColorScheme(.dark)
        }
    }
}

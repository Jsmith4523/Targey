//
//  SelectedMerchandiseView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/21/22.
//

import SwiftUI

struct SelectedMerchandiseView: View {
    
    @State private var isShowingActivityView = false
    @State private var isShowingStoreStockView = false
    
    let merchandise: Merchandise
    
    var product: product {
        merchandise.product
    }
    
    var offer: offers {
        merchandise.offers
    }
    
    @StateObject private var locationModel = LocationServicesManager()
    @ObservedObject var searchModel: SearchViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        TabView {
                            ForEach(product.productImagesURL, id: \.self) { url in
                                AsyncImage(url: url) { image in
                                    image
                                        .productImageStyle()
                                       
                                } placeholder: {
                                    Image.placeholderProductImage
                                        .productImageStyle()
                                }
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        .frame(height: 445)
                    }
                    MerchandiseDetailsView(merchandise: merchandise)
                    Spacer()
                }
                Button {
                    //TODO: Save to CoreData
                } label: {
                    FavoritesButtonView(searchModel: searchModel, merchandise: merchandise)
                }
            }
        })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    //TODO: Implement Share sheet
                    self.isShowingActivityView.toggle()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                Menu {
                    Button {
                        URL.openTargetURL(product.targetURL)
                    } label: {
                        Label("Target App", systemImage: "iphone")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
            ToolbarItemGroup(placement: .principal) {
                if let favoriteStore = searchModel.locationManager?.favoriteStore {
                    Button {
                        isShowingStoreStockView.toggle()
                    } label: {
                        Text(favoriteStore.name)
                            .font(.system(size: 14).weight(.semibold))
                            .foregroundColor(.reversed)
                    }
                } else {
                    EmptyView()
                }
            }
        }
        .accentColor(.targetRed)
        .customSheetView(isPresented: $isShowingActivityView, detents: [.medium(), .large()], showsIndicator: false, cornerRadius: 15) {
            ActivityController(activities: [product.targetURL]).edgesIgnoringSafeArea(.bottom)
            
        }
        .sheet(isPresented: $isShowingStoreStockView) {
            MerchandiseStockView(merchandise: merchandise)
        }
        .onAppear {
            searchModel.locationManager = locationModel
        }
    }
}

fileprivate struct MerchandiseDetailsView: View {
    
    let merchandise: Merchandise
    
    var product: product {
        merchandise.product
    }
    
    var offer: offers {
        merchandise.offers
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(product.title)
                .font(.system(size: 23).weight(.bold))
                .lineLimit(2)
            ratingView(rating: product.productRating, reviewCount: product.productRatingTotal)
            offer.primary.productPriceLabel
                .font(.system(size: 18.5))
            Spacer()
                .frame(height: 10)
            ForEach(product.productBullets, id: \.self) {
                Text($0)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding()
    }
}

fileprivate struct FavoritesButtonView: View {
    
    @ObservedObject var searchModel: SearchViewModel

    let merchandise: Merchandise
    
    var body: some View {
        ZStack {
            Label("Favorite", systemImage: "heart")
        }
        .padding()
        .font(.system(size: 18).weight(.semibold))
        .foregroundColor(.white)
        .frame(width: 275)
        .background(.red)
        .cornerRadius(5)
    }
}

struct SelectedMerchandiseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SelectedMerchandiseView(merchandise: testerMerchandise, searchModel: SearchViewModel())
        }
    }
}

let testerMerchandise: Merchandise = .init(position: 0, product: .init(title: "Playstation 5", link: "https://www.target.com/p/playstation-5-god-of-war-ragnarok-console-with-wireless-controller/-/A-87800909?ref=tgt_adv_XS000000&AFID=google_pla_df&fndsrc=tgtao&DFA=71700000014846099&CPNG=PLA_Electronics%2BShopping_Brand%7CElectronics_Ecomm_Hardlines&adgroup=SC_Electronics&LID=700000001170770pgs&LNM=PRODUCT_GROUP&network=g&device=c&location=9007722&targetid=pla-305534446499&ds_rl=1246978&ds_rl=1248099&gclid=Cj0KCQiA-oqdBhDfARIsAO0TrGHPzxGVYCfwHGldDr56pYFK0E6dmyCgL549N9GXgqGX6sTXNnOTQf0aAk4dEALw_wcB&gclsrc=aw.ds", tcin: "342343", dpci: "203-43-221", feature_bullets: ["Here's a story abut making an apple pie", "First, get some apples", "Then pie"], rating: 0, rating_total: 456, main_image: "https://target.scene7.com/is/image/Target/GUEST_ae4e8352-bcea-4dd7-97ad-13be08ec32fb?wid=325&hei=325&qlt=80&fmt=pjpeg", images: ["https://target.scene7.com/is/image/Target/GUEST_224eb8d4-90f8-4fbb-a5d7-c54ab8a517bf?wid=325&hei=325&qlt=80&fmt=pjpeg", "https://target.scene7.com/is/image/Target/GUEST_ae4e8352-bcea-4dd7-97ad-13be08ec32fb?wid=325&hei=325&qlt=80&fmt=pjpeg"]), offers: .init(primary: .init(price: 559.99, symbol: "$", regular_price: nil)))

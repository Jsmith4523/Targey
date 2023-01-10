//
//  ImageParralaxView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/10/23.
//

import Foundation
import SwiftUI


///Sticky Image header that can animate based off its avaliable space. Only provide the imageURL
struct ImageParralaxView: View {

    let imageURL: URL
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.frame(in: .global).minY > 0 ? geo.frame(in: .global).minY + (UIScreen.main.bounds.height / 3) : UIScreen.main.bounds.height / 3)
                        .clipped()
                } placeholder: {
                    Image("black")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width, height: geo.frame(in: .global).minY > 0 ? geo.frame(in: .global).minY + (UIScreen.main.bounds.height / 2.2) : UIScreen.main.bounds.height / 2.2)
                        .clipped()
                }
            }
            .frame(width: geo.size.width, height: geo.frame(in: .global).minY > 0 ? geo.frame(in: .global).minY + (UIScreen.main.bounds.height / 2.2) : UIScreen.main.bounds.height / 2.2)
            .offset(y: -geo.frame(in: .global).minY)
        }
    }
}

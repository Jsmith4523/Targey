//
//  CameraOutputView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/7/23.
//

import Foundation
import SwiftUI

struct BarcodeScannerOutputView: View {
    
    @State private var recWidth: CGFloat = UIScreen.main.bounds.width-100
    @State private var recHeight: CGFloat = 200
    
    @ObservedObject var cameraModel: CameraModel
    
    var body: some View {
        ZStack {
            CameraSession(cameraModel: cameraModel)
                 .overlay {
                     RoundedRectangle(cornerRadius: 15)
                         .stroke(.white)
                         .frame(width: recWidth, height: recHeight)
                 }
        }
        .ignoresSafeArea()
    }
}

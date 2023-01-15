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
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                CameraSession(cameraModel: cameraModel)
                     .overlay {
                         RoundedRectangle(cornerRadius: 15)
                             .stroke(.white, lineWidth: 3)
                             .frame(width: recWidth, height: recHeight)
                     }
            }
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if cameraModel.deviceHasTorch {
                        Button {
                            
                        } label: {
                            Image(systemName: cameraModel.torchIsOn ? "flashlight.on.fill" : "flashlight.off.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                                .foregroundColor(cameraModel.torchIsOn ? .red : .white)
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
                            .shadow(radius: 3)
                    }
                }
            }
        }
        .accentColor(.white)
    }
}

struct Previews_CameraOutputView_Previews: PreviewProvider {
    static var previews: some View {
       BarcodeScannerOutputView(cameraModel: CameraModel())
            .preferredColorScheme(.dark)
    }
}

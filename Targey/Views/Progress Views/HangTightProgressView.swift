//
//  HangTightProgressView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/10/23.
//

import Foundation
import SwiftUI

struct HangTightProgressView: View {
   var body: some View {
       VStack(alignment: .center) {
           Spacer()
           Image.dogOne
               .dogSymbolStyle()
           Text("Hang tight! We're running through aisles as fast as we can!")
               .font(.system(size: 16))
               .foregroundColor(.gray)
               .multilineTextAlignment(.center)
           Spacer()
       }
       .padding()
   }
}

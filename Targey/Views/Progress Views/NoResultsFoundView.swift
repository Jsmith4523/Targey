//
//  NoResultsFoundView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/10/23.
//

import Foundation
import SwiftUI

struct NoResultsFoundView: View {
   
   var body: some View {
       VStack(alignment: .center) {
           Spacer()
           Text("We did the best we could. That product is no where to be found!")
               .font(.system(size: 16))
               .foregroundColor(.gray)
               .multilineTextAlignment(.center)
           Spacer()
       }
       .padding()
   }
}


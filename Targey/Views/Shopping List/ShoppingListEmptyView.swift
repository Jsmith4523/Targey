//
//  ShoppingListEmptyView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/10/23.
//

import Foundation
import SwiftUI

struct ShoppingListEmptyView: View {
       
   var body: some View {
       VStack {
           Spacer()
           Image.dogBag
               .resizable()
               .scaledToFit()
               .frame(width: 65, height: 65)
               .padding()
           Text("Your List is Empty")
               .font(.system(size: 23).bold())
           Text("Stay organized by adding everyday items that you can't live without.")
               .multilineTextAlignment(.center)
               .padding()
           Spacer()
               
       }
       .padding()
   }
}

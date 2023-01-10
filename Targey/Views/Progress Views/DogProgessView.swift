//
//  DogProgessView.swift
//  Targey
//
//  Created by Jaylen Smith on 1/10/23.
//

import SwiftUI

struct DogProgessView: View {
    var body: some View {
        VStack {
            Spacer()
            Image.dogOne
                .resizable()
                .scaledToFit()
                .frame(width: 125, height: 125)
            ProgressView()
            Spacer()
        }
    }
}

struct DogProgessView_Previews: PreviewProvider {
    static var previews: some View {
        DogProgessView()
    }
}

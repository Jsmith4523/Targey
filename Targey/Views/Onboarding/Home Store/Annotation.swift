//
//  Annotation.swift
//  Targey
//
//  Created by Jaylen Smith on 12/23/22.
//

import SwiftUI

struct Annotation: View {
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "triangle.fill")
                    .rotationEffect(.degrees(-180))
                    .offset(y: 15)
                    .foregroundColor(.targetRed)
                Image("store")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 28, height: 28)
                    .clipShape(Circle())
                    .padding(4)
                    .background(Color.targetRed)
                    .clipShape(Circle())
            }
            Spacer()
        }
        .frame(height: 75)
    }
}

struct Annotation_Previews: PreviewProvider {
    static var previews: some View {
        Annotation()
            .preferredColorScheme(.dark)
    }
}

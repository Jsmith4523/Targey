//
//  ThankYouView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/24/22.
//

import SwiftUI

struct ThankYouView: View {
    
    @ObservedObject var onboardModel: OnBoardModel
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            Image.phoneuser
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            Text("That's all we need!")
                .font(.system(size: 25).bold())
                .multilineTextAlignment(.center)
            Text("Thank you for downloading and please enjoy the project! ")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
            
            Button("Jump In") {
                onboardModel.didFinishOnboarding()
            }
            .foregroundColor(.targetRed)
            Spacer()
        }
    }
}

struct ThankYouView_Previews: PreviewProvider {
    static var previews: some View {
        ThankYouView(onboardModel: OnBoardModel())
    }
}

//
//  WelcomeView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/23/22.
//

import SwiftUI

struct WelcomeView: View {
    
    @ObservedObject var onboardModel: OnBoardModel
    @ObservedObject var locationManager: LocationServicesManager
    
    var body: some View {
        VStack {
            Image.dogOne
                .dogSymbolStyle()
            Text("Welcome to Targey!")
                .font(.system(size: 35).bold())
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 50)
            Text("This project was made my Bowie State University student Jaylen Smith. Who actually loves the official app and took it into thier hands to make their own!")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 20)
            NavigationLink {
                HomeStoreView(onboardModel: onboardModel, locationManager: locationManager)
            } label: {
                Text("Next")
                    .foregroundColor(.targetRed)
            }
            Spacer()
        }
        .padding()
        .accentColor(.targetRed)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(onboardModel: OnBoardModel(), locationManager: LocationServicesManager())
    }
}

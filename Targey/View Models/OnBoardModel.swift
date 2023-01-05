//
//  OnBoardModel.swift
//  Targey
//
//  Created by Jaylen Smith on 12/24/22.
//

import Foundation
import SwiftUI

final class OnBoardModel: ObservableObject {
    
    @AppStorage ("isOnboarded") var isOnboarded = false
    
    func didFinishOnboarding() {
        withAnimation {
            isOnboarded.toggle()
        }
    }
}

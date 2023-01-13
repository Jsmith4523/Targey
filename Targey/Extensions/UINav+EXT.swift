//
//  UINav+EXT.swift
//  Targey
//
//  Created by Jaylen Smith on 12/22/22.
//

import Foundation
import SwiftUI
import UIKit

extension UINavigationController: UINavigationControllerDelegate {
   
    open override func viewWillLayoutSubviews() {
        self.navigationBar.topItem?.backButtonDisplayMode = .minimal
    
    }
}



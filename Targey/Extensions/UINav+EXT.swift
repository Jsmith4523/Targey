//
//  UINav+EXT.swift
//  Targey
//
//  Created by Jaylen Smith on 12/22/22.
//

import Foundation
import UIKit

extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        self.navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}

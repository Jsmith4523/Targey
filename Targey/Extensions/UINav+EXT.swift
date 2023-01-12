//
//  UINav+EXT.swift
//  Targey
//
//  Created by Jaylen Smith on 12/22/22.
//

import Foundation
import SwiftUI
import UIKit

public protocol DiscoverNavigationBarDelegate {
    func viewIsPresented()
    func revertToOriginal()
}

extension UINavigationController: UINavigationControllerDelegate {
    
    public func revertToOriginal() {
        let navBarAppearanceScroll = UINavigationBarAppearance()
        let navBarAppearanceStandard = UINavigationBarAppearance()

        self.navigationBar.standardAppearance = navBarAppearanceStandard
        self.navigationBar.scrollEdgeAppearance = navBarAppearanceScroll
    }
    
    public func viewIsPresented() {
        let navBarAppearanceStandard = UINavigationBarAppearance()
        
        let navBarAppearanceScroll = UINavigationBarAppearance()
        navBarAppearanceScroll.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearanceScroll.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearanceScroll.backgroundColor = UIColor(Color.targetRed)
        
        self.navigationBar.standardAppearance = navBarAppearanceStandard
        self.navigationBar.scrollEdgeAppearance = navBarAppearanceScroll
    }
    
    open override func viewWillLayoutSubviews() {
        self.navigationBar.topItem?.backButtonDisplayMode = .minimal
    
    }
}



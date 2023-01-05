//
//  TargeyApp.swift
//  Targey
//
//  Created by Jaylen Smith on 12/20/22.
//

/*
 
 DISCLAIMER PLEASE READ:
 This application is a project and shall not be distrubted to the Apple App Store, Testflight, or significant!!
 
 Product images, merchandise, and other information are provided by RedCircleAPI
 I do not hold any possession of images or information displayed in the application.
 Target company logos and glyphs are provided by Target.
 I do not hold any possession of them.
 
 */

import SwiftUI

@main
struct TargeyApp: App {
        
    @UIApplicationDelegateAdaptor (AppDegelate.self) var appDelegate
    
    @StateObject var onboardModel    = OnBoardModel()
    @StateObject var locationManager = LocationServicesManager()
    @StateObject var searchViewModel = SearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch onboardModel.isOnboarded {
                case true:
                    Tab()
                case false:
                    NavigationView {
                        WelcomeView(onboardModel: onboardModel, locationManager: locationManager)
                            .accentColor(.targetRed)
                    }
                }
            }
            .accentColor(.targetRed)
        }
    }
}

class AppDegelate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let appearance = UITabBarAppearance()
        
        appearance.shadowColor     = .systemBackground
        appearance.backgroundColor = .systemBackground
        
        UITabBar.appearance().standardAppearance   = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        
        UIPageControl.appearance().currentPageIndicatorTintColor      = UIColor(Color.targetRed)
        UIPageControl.appearance().pageIndicatorTintColor             = UIColor.opaqueSeparator
        
        UINavigationBar.appearance().backIndicatorImage               = UIImage(systemName: "arrow.left")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
                
        return true
    }
}

//
//  AppDelegate.swift
//  GBShop
//
//  Created by Антон Васильченко on 11.02.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let baseUrlGitGB = URL(
        string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/") ?? URL(fileURLWithPath: ""
        )
    static let baseUrlHeroku = URL(
        string: "https://whispering-waters-74907.herokuapp.com/") ?? URL(fileURLWithPath: ""
        )
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
}

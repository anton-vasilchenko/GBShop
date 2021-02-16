//
//  AppDelegate.swift
//  GBShop
//
//  Created by Антон Васильченко on 11.02.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    let requestFactory = RequestFactory()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let signUp = requestFactory.makeSignUpRequestFactory()
        signUp.signUp(id: "1", username: "TestUser", password: "TestPassword", email: "123@123.com", gender: "m", creditCard: "123123123123", bio: "Some bio!") { response in
            switch response.result {
            case .success(let message):
                print(message)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return true
    }
        
    
}


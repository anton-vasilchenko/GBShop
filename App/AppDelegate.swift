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
        //            let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
        
        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                print("Login")
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let signUp = requestFactory.makeSignUpRequestFactory()
        signUp.signUp(id: "1", username: "TestUser", password: "TestPassword", email: "123@123.com", gender: "m", creditCard: "123123123123", bio: "Some bio!") { response in
            switch response.result {
            case .success(let message):
                print("SignUp")
                print(message)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let logout = requestFactory.makeLogoutRequestFactory()
        logout.logout(id: "1") { response in
            switch response.result {
            case .success(let logout):
                print("Log Out")
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        

        
        let changeUserData = requestFactory.makeChangeUserDataRequestFactory()
        changeUserData.changeData(id: "1", username: "TestUser", password: "TestPassword", email: "123@123.com", gender: "m", creditCard: "123123123123", bio: "Some bio!") { response in
            switch response.result {
            case .success(let changeUserData):
                print("Change data")
                print(changeUserData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let getCatalogData = requestFactory.makeCatalogDataRequestFactory()
        getCatalogData.getCatalogData(id: 1) { (response) in
            switch response.result {
            case .success(let catalogData):
                print("Recieved catalog data")
                print(catalogData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let getGoodById = requestFactory.makeGetGoodByIdRequestFactory()
        getGoodById.getGoodById(id: 1) { (response) in
            switch response.result {
            case .success(let good):
                print("Got good by ID")
                print(good)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let addReview = requestFactory.makeAddReviewRequestFactory()
        addReview.addReview(id: 123, reviewText: "Review text") { (response) in
            switch response.result {
            case .success(let review):
                print("Review added")
                print(review)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let removeReview = requestFactory.makeRemoveReviewRequestFactory()
        removeReview.removeReview(id: 123) { (response) in
            switch response.result {
            case .success(let review):
                print("Review removed")
                print(review)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        
        return true
    }
    
    
}


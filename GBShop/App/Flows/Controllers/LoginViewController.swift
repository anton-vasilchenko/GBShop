//
//  LoginViewController.swift
//  GBShop
//
//  Created by Антон Васильченко on 11.03.2021.
//

import UIKit
import OSLog
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let requestFactory = RequestFactory()
    
    //    private let requestFactory: RequestFactory
    //
    //    init?(coder:NSCoder, requestFactory: RequestFactory) {
    //        self.requestFactory = requestFactory
    //        super.init(coder: coder)
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    let app = App.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseAnalytics.Analytics.logEvent(AnalyticsEventLogin, parameters: [
          AnalyticsParameterSuccess: "1",
          AnalyticsParameterCurrency: "USD"
        ])
    }
    @IBAction func loginButtonPresed(_ sender: Any) {
        let auth = requestFactory.makeAuthRequestFatory()
        
        auth.login(userName: loginTextField.text ?? "", password: passwordTextField.text ?? "") { response in
            switch response.result {
            case .success(let login):
                print("Login")
                print(login.user)
                self.app.user.append(login.user)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "login", sender: self.loginButton)
                }
                
                FirebaseAnalytics.Analytics.logEvent("login", parameters: [
                    "name": "login" as NSObject,
                    "fullText": "loginWithSuccess" as NSObject
                ])
            case .failure(let error):
                FirebaseAnalytics.Analytics.logEvent("login", parameters: [
                    "name": "login" as NSObject,
                    "fullText": "loginWithFailure" as NSObject
                ])
                FirebaseCrashlytics.Crashlytics.crashlytics().record(error: error)
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
}

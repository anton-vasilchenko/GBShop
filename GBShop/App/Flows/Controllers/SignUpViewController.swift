//
//  SignUpViewController.swift
//  GBShop
//
//  Created by Антон Васильченко on 11.03.2021.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var creditCardTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    let requestFactory = RequestFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let signUp = requestFactory.makeSignUpRequestFactory()
        signUp.signUp(id: (userIDTextField.text! as NSString).integerValue,
                      username: usernameTextField.text ?? "",
                      password: passwordTextField.text ?? "",
                      email: emailTextField.text ?? "",
                      gender: genderTextField.text ?? "",
                      creditCard: creditCardTextField.text ?? "",
                      bio: bioTextField.text ?? "") { response in
            switch response.result {
            case .success(let message):
                print("SignUp")
                print(message)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "signUp", sender: self.signUpButton)
                }
                FirebaseAnalytics.Analytics.logEvent("signup", parameters: [
                    "name": "username" as NSObject,
                    "fullText": "loginWithSuccess" as NSObject
                ])
            case .failure(let error):
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

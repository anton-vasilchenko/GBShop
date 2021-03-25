//
//  LoginViewController.swift
//  GBShop
//
//  Created by Антон Васильченко on 11.03.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let requestFactory = RequestFactory()
    let app = App.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
}

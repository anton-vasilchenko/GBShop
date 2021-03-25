//
//  UserViewController.swift
//  GBShop
//
//  Created by Антон Васильченко on 11.03.2021.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var creditCardTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    
    @IBOutlet weak var changeDataButton: UIButton!
    
    let requestFactory = RequestFactory()
    
    let app = App.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
        idLabel.text = String(app.user[0].id)
        loginLabel.text = app.user[0].login
        nameLabel.text = app.user[0].name
        lastNameLabel.text = app.user[0].lastname
    }
    
    @IBAction func changeDataButtonTapped(_ sender: Any) {
        
        let changeUserData = requestFactory.makeChangeUserDataRequestFactory()
        changeUserData.changeData(id: idTextField.text ?? "1", username: usernameTextField.text ?? "TestUser", password: passwordTextField.text ?? "TestPassword", email: emailTextField.text ?? "123@123.com", gender: genderTextField.text ?? "m", creditCard: creditCardTextField.text ?? "123123123123", bio: bioTextField.text ?? "Some bio!") { response in
            switch response.result {
            case .success(let changeUserData):
                print("Change data")
                print(changeUserData)
                DispatchQueue.main.async {
                let alert = UIAlertController(title: "User data", message: "Data was successfully changed", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

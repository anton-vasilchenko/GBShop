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
    
    let app = App.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
        idLabel.text = String(app.user[0].id)
        loginLabel.text = app.user[0].login
        nameLabel.text = app.user[0].name
        lastNameLabel.text = app.user[0].lastname
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

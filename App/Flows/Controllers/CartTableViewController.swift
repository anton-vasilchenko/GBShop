//
//  CartTableViewController.swift
//  GBShop
//
//  Created by Антон Васильченко on 11.03.2021.
//

import UIKit
import Foundation

class CartTableViewController: UITableViewController {
    @IBOutlet weak var priceFooterLabel: UILabel!
    @IBOutlet weak var buyFooterButton: UIButton!
    var totalPrice = 0
    
    let requestFactory = RequestFactory()
    var catalogData: [CatalogDataResultElement] = []
    var cartItems: [CatalogDataResultElement] = []
    
    @IBAction func buyButtonTapped(_ sender: Any) {
        let payBasket = requestFactory.makePayBasketRequestFactory()
        payBasket.payBasket(idPayProve: 123) { (response) in
            switch response.result {
            case .success(let model):
                print("Payment accepted")
                print(model)
                self.cartItems = []
                self.totalPrice = 0
                DispatchQueue.main.async {
                    self.priceFooterLabel.text = String(self.totalPrice)
                    let alert = UIAlertController(title: "Buy", message: "Payment succeded", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        
        let refreshControl = UIRefreshControl()

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    @objc func refresh () {
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell else { return UITableViewCell() }
        
        cell.nameLabel?.text = cartItems[indexPath.row].productName
        cell.priceLabel?.text = String(cartItems[indexPath.row].price)
//        totalPrice = cartItems.reduce(into: <#Int#>, {$0 += ($1.price ?? 0)})
        totalPrice = cartItems.lazy.compactMap {$0.price}.reduce(0, +)
        priceFooterLabel.text = String(totalPrice)
        
        switch cartItems[indexPath.row].productName {
        case "Ноутбук":
            cell.goodPicture.image = UIImage(named: "Laptop")
        case "Мышка":
            cell.goodPicture.image = UIImage(named: "Mouse")
        default:
            cell.goodPicture.image = UIImage(named: "noImage")
        }
        
        return cell
    }
    
}

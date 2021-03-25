//
//  MainTableViewController.swift
//  GBShop
//
//  Created by Антон Васильченко on 11.03.2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var catalogData: [CatalogDataResultElement] = []
    var cartItems: [CatalogDataResultElement] = []
    let requestFactory = RequestFactory()
    var cartController: CartTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
        cartController = self.tabBarController?.viewControllers![1] as? CartTableViewController
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        
    }
    
    func loadData () {
        
        let getCatalogData = requestFactory.makeCatalogDataRequestFactory()
        getCatalogData.getCatalogData(id: 1) { (response) in
            switch response.result {
            case .success(let catalogData):
                print("Recieved catalog data")
                print(catalogData)
                self.catalogData = catalogData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalogData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        cell.nameLabel?.text = catalogData[indexPath.row].productName
        cell.priceLabel?.text = String(catalogData[indexPath.row].price)
        cell.addButton.tag = indexPath.row
        cell.addButton.addTarget(self, action: #selector(addToCartTapped(_:)), for: .touchUpInside)
        
        switch catalogData[indexPath.row].productName {
        case "Ноутбук":
            cell.goodPicture.image = UIImage(named: "Laptop")
        case "Мышка":
            cell.goodPicture.image = UIImage(named: "Mouse")
        default:
            cell.goodPicture.image = UIImage(named: "noImage")
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? GoodViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            let item = catalogData[indexPath.row]
            controller.item = item
        }
        if let controller = segue.destination as? CartTableViewController {
            controller.cartItems = cartItems
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "good", sender: nil)
    }
    
    @objc func addToCartTapped(_ sender: UIButton) {
        let item = catalogData[sender.tag]
        cartController.cartItems.append(item)
        cartController.tableView.reloadData()
        
        let addToBasket = requestFactory.makeAddToBasketRequestFactory()
        addToBasket.addToBasket(id: item.idProduct, quantity: 1) { (response) in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Message", message: "Add to basket \(item.productName)", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

//
//  MainTableViewController.swift
//  GBShop
//
//  Created by Антон Васильченко on 11.03.2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var catalogData: [CatalogDataResultElement] = []
    let requestFactory = RequestFactory()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

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
//                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return catalogData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = catalogData[indexPath.row].productName
        cell.detailTextLabel?.text = String(catalogData[indexPath.row].price)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addToBasket = requestFactory.makeAddToBasketRequestFactory()
        addToBasket.addToBasket(id: catalogData[indexPath.row].idProduct, quantity: 1) { (response) in
            switch response.result {
            case .success(let review):
                print("Added to basket")
                print(review)
                DispatchQueue.main.async {
                let alert = UIAlertController(title: "Message", message: "Add to basket", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

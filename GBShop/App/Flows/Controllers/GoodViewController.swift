//
//  GoodViewController.swift
//  GBShop
//
//  Created by Антон Васильченко on 16.03.2021.
//

import UIKit
import Firebase

class GoodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var reviewTable: UITableView!
    
    let requestFactory = RequestFactory()
    var item: CatalogDataResultElement!
    var cartController: CartTableViewController!
    var reviewList: [ReviewListResultElement] = []
    var cartItems: [CatalogDataResultElement] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseAnalytics.Analytics.logEvent(AnalyticsEventViewItem, parameters: [
                                                AnalyticsParameterItemID: item.idProduct,
                                                AnalyticsParameterSuccess: "ok"])
        
        nameLabel.text = item.productName
        priceLabel.text = String(item.price)
        
        addToCartButton.addTarget(self, action: #selector(addToCartTapped(_:)), for: .touchUpInside)
        switch item.productName {
        case "Ноутбук":
            productImageView.image = UIImage(named: "Laptop")
        case "Мышка":
            productImageView.image = UIImage(named: "Mouse")
        default:
            productImageView.image = UIImage(named: "noImage")
        }
        
        reviewTable.dataSource = self
        reviewTable.delegate = self
        
        loadReviews()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? MainTableViewController {
            controller.cartItems.append(contentsOf: self.cartItems)
        }
    }
    
    func loadReviews() {
        
        let reviewList = requestFactory.makeReviewListRequestFactory()
        reviewList.reviewList(idUser: 123, pageNumber: "1") { (response) in
            switch response.result {
            case .success(let model):
                self.reviewList = model
                DispatchQueue.main.async {
                    self.reviewTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath)
        let review = reviewList[indexPath.row]
        cell.textLabel?.text = review.commentText
        cell.detailTextLabel?.text = String(review.idUser)
        return cell
    }
    
    @objc func addToCartTapped(_ sender: UIButton) {
        let addToBasket = requestFactory.makeAddToBasketRequestFactory()
        cartItems.append(item)

        addToBasket.addToBasket(id: item.idProduct, quantity: 1) { (response) in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Message", message: "Add to basket \(self.item.productName)", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                FirebaseAnalytics.Analytics.logEvent(AnalyticsEventAddToCart, parameters: [
                                                        AnalyticsParameterItemID: self.item.idProduct,
                                                        AnalyticsParameterSuccess: "ok"])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

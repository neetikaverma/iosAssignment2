//
//  RestokeVC.swift
//  CashRegisterAssignment
//
//  Created by user199585 on 21/10/21.
//

import UIKit

class RestokeVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var qtyTextField: UITextField!
    @IBOutlet weak var productsTable: UITableView!
    
    var selectedIndex: Int = -1
    var productsList = [Product(id: "1", name: "Pants", quantity: 10, price: 150),
                    Product(id: "2", name: "Shoes", quantity: 20, price: 180.5),
                    Product(id: "3", name: "Hats", quantity: 5, price: 30.7),
                    Product(id: "4", name: "Tshirts", quantity: 12, price: 60),
                    Product(id: "5", name: "Dresses", quantity: 14, price: 200),
                    Product(id: "6", name: "Shirts", quantity: 30, price: 100),
                    Product(id: "7", name: "Socks", quantity: 2, price: 20.2)]
    override func viewDidLoad() {
        super.viewDidLoad()
        productsTable.delegate = self
        productsTable.dataSource = self
    }
    
    //MARK:- Actions
    @IBAction func restock(_ sender: UIButton) {
        if(selectedIndex != -1) {
            productsList[selectedIndex].quantity = Int(qtyTextField.text?.numbers ?? "0") ?? 0
            productsTable.reloadData()
        }
        else {
            alert(title: "Error", message: "You have to select an item and provide a new quantity")
        }
    }
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func cancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension RestokeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RestockProductCell
        cell.lblTitle.text = productsList[indexPath.row].name
        cell.lblQuantity.text = "\(productsList[indexPath.row].quantity)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
}

class RestockProductCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    
}

//
//  CashRegisterVC.swift
//  CashRegisterAssignment
//
//  Created by user199585 on 20/10/21.
//

import UIKit

class CashRegisterVC: UIViewController {
    
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var btnManager: UIButton!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var productsTable: UITableView!
    
    var selectedIndex = -1
    
    var productList = [Product(id: "1", name: "Pants", quantity: 10, price: 150),
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productsTable.reloadData()
    }
    
    func revisedPrice() {
        if(selectedIndex != -1) {
            let quantity = Double(lblQuantity.text ?? "0")
            lblTotal.text = "\(productList[selectedIndex].price * (quantity != nil ? quantity! : 0))"
            lblTotal.text = lblTotal.text == "0" ? "Total" : lblTotal.text
        }
    }
    func reset() {
        lblQuantity.text = "Quantity"
        lblTotal.text = "Total"
        lblType.text = "Type"
        
        selectedIndex = -1
    }
  

    @IBAction func digitsButton(_ sender: UIButton) {
        lblQuantity.text = (lblQuantity.text! + "\(sender.tag)").numbers
        revisedPrice()
    }
    @IBAction func buttonAction(_ sender: UIButton) {
        var quantityString: String = lblQuantity.text!
        if(quantityString.count > 0 && quantityString != "Quantity") {
            quantityString.remove(at: quantityString.index(before: quantityString.endIndex))
            lblQuantity.text = quantityString
        }
        
        if(quantityString.count == 0) {
            lblQuantity.text = "Quantity"
        }
        
        revisedPrice()
    }
    @IBAction func buy(_ sender: UIButton) {
        if(selectedIndex != -1) {
            guard let quantity = Int(lblQuantity.text!), quantity > 0 else {
                return
            }
            if(productList[selectedIndex].quantity >= quantity) {
                productList[selectedIndex].quantity = productList[selectedIndex].quantity - quantity
                productsTable.reloadData()
                arrHistory.append(PurchasedProduct(id: productList[selectedIndex].id, name: productList[selectedIndex].name, quantity: quantity, totalPrice: Double(quantity) * productList[selectedIndex].price, purchaseDateTime: Date().toString(format: "MM/DD/YYYY hh:mm:ss a")))
                btnManager.isHidden = false
                reset()
            }
            else {
                alert(title: "Alert", message: "invalid quantity")
            }
        }
        else {
            alert(title: "Error", message: "invalid item")
        }
    }
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension CashRegisterVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductCell
        cell.lblTitle.text = productList[indexPath.row].name
        cell.lblPrice.text = "\(productList[indexPath.row].price)"
        cell.lblQuantity.text = "\(productList[indexPath.row].quantity)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        lblType.text = productList[indexPath.row].name
        revisedPrice()
    }
    
}
extension String {
    var numbers: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}
extension Double {
    func points(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

class ProductCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    
}

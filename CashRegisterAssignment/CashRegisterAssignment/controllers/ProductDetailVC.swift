//
//  ProductDetailVC.swift
//  CashRegisterAssignment
//
//  Created by user199585 on 21/10/21.
//

import UIKit

class ProductDetailVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var lblDetail: UILabel!
    
    var selectedProduct: PurchasedProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    
    func initData() {
        guard let selectedProduct = selectedProduct else {
            return
        }
        title = selectedProduct.name
        lblDetail.text = "\(selectedProduct.name)\n\(selectedProduct.quantity)\n\(selectedProduct.purchaseDateTime)\nTotal amount : \(selectedProduct.totalPrice)"
    }
    
}

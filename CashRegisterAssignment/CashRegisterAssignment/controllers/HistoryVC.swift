//
//  HistoryVC.swift
//  CashRegisterAssignment
//
//  Created by user199585 on 21/10/21.
//

import UIKit

class HistoryVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var historyTable: UITableView!
    
    var selectedProduct: PurchasedProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTable.delegate = self
        historyTable.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "historySegue" {
            if let targetController = segue.destination as? ProductDetailVC {
                targetController.selectedProduct = selectedProduct
            }
        }
    }
}

extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHistory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell =
            UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                        reuseIdentifier: "cell")
        cell.textLabel?.text = arrHistory[indexPath.row].name
        cell.detailTextLabel?.text = "\(arrHistory[indexPath.row].quantity)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        selectedProduct = arrHistory[indexPath.row]
        self.performSegue(withIdentifier: "historySegue", sender: self)
    }
}

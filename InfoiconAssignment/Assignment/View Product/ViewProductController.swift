//
//  ViewProductController.swift
//  InfoiconAssignment
//
//  Created by Deepak's Mac on 08/03/23.
//

import Foundation
import UIKit

class ViewProductController : UIViewController{
    
    var productId = ""
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBtn: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var viewModel : ProductDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ProductDetailViewModel()
        self.viewModel.ProductId = self.productId
        
        tableView.register(ViewProductTableViewCell.nib, forCellReuseIdentifier: ViewProductTableViewCell.identifier)
        tableView.dataSource = self.viewModel
        tableView.delegate = self.viewModel
        self.viewModel.tableView = self.tableView
        
        self.viewModel.controller = self
        self.navigationItem.title = "Detail"
        self.navigationController?.navigationBar.backgroundColor = UIColor.systemOrange
        
        callingApi()
        
    }
    
    @IBAction func editBtnClicked(_ sender: Any) {
        
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "AddProductController") as! AddProductController
        nav.sourceController = "Edit"
        nav.editProductId = self.productId
        
        nav.title1 = viewModel.model?.title ?? ""
        nav.category = viewModel.model?.category ?? ""
        nav.image = viewModel.model?.image ?? ""
        nav.desc = viewModel.model?.description ?? ""
        nav.price1 = String(format: "%.2f",viewModel.model?.price as! CVarArg)
        self.navigationController?.pushViewController(nav, animated: true)
        
    }
    
    
    func callingApi(){
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        viewModel.callRequest(whichApiCall: "ViewProduct",completion: {results in
            if results{
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.tableView.reloadData()
                }
                
            }
        })
        
    }
}

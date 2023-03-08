//
//  ViewController.swift
//  InfoiconAssignment
//
//  Created by Deepak's Mac on 07/03/23.
//

import UIKit

class ProductListController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel : ProductListViewModel!
    
    @IBOutlet weak var addProductBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//self.viewModel.tableView = tableView.self
        
      
        
        self.viewModel = ProductListViewModel()
        tableView.register(ProductListTableViewCell.nib, forCellReuseIdentifier: ProductListTableViewCell.identifier)
        tableView.dataSource = self.viewModel
        tableView.delegate = self.viewModel
        self.viewModel.tableView = self.tableView
        self.viewModel.controller = self
        self.navigationItem.title = "Home Product Data"
        self.navigationController?.navigationBar.backgroundColor = UIColor.systemOrange
        
        callingApi()
    }
    
    
    @IBAction func addProductClicked(_ sender: Any) {
        
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "AddProductController") as! AddProductController
        nav.sourceController = "Add"
        self.navigationController?.pushViewController(nav, animated: true)
        
        
    }
    
    
    
    
    func callingApi(){
        self.activityIndicator.startAnimating() 
        self.activityIndicator.isHidden = false
        viewModel.callRequest(whichApiCall: "GetProductList",completion: {results in
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


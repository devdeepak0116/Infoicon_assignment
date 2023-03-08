//
//  AddProductController.swift
//  InfoiconAssignment
//
//  Created by Deepak's Mac on 08/03/23.
//

import Foundation
import UIKit

class AddProductController : UIViewController {
    
    var editProductId = ""
    var productDict = [String: Any]()
    var sourceController = ""
    var viewModel : AddEditViewModel!
    var title1 = ""
    var price1 = ""
    var desc = ""
    var category = ""
    var image = ""
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var imageUrlField: UITextField!
    @IBOutlet weak var price: UITextField!
    
    @IBOutlet weak var categoryField: UITextField!
   
    @IBOutlet weak var descField: UITextField!
    
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = AddEditViewModel()
        if sourceController == "Add"{
            self.addBtn.setTitle("Save", for: .normal)
        }else{
            self.addBtn.setTitle("Save", for: .normal)
            
            titleField.text = title1
            price.text = price1
            categoryField.text = category
            imageUrlField.text = image
            descField.text = desc
            
            

        }
        self.viewModel.editId = editProductId
        self.navigationItem.title = "Add/Edit Product"
        self.navigationController?.navigationBar.backgroundColor = UIColor.systemOrange
        
        
        
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        
        viewModel.title = titleField.text ?? ""
        viewModel.price = Double(price.text ?? "")!
        viewModel.category = categoryField.text ?? ""
        viewModel.desc = descField.text ?? ""
        viewModel.image = imageUrlField.text ?? ""
        
        
        if sourceController == "Add"{
            viewModel.callRequest(whichApiCall: "Add", completion: {data in
                if data{
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: nil, message: "Product Updated successfully", preferredStyle: .alert)
                        //alert.view.backgroundColor = UIColor.
                        alert.view.alpha = 0.5
                        alert.view.layer.cornerRadius = 15
                        self.present(alert, animated: true)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            alert.dismiss(animated: true)
                        }
                    }
                    
                }
                
            })
        }else{
            viewModel.callRequest(whichApiCall: "Edit", completion: {data in
                if data{
              
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: nil, message: "Product Updated successfully", preferredStyle: .alert)
                        //alert.view.backgroundColor = UIColor.
                        alert.view.alpha = 0.5
                        alert.view.layer.cornerRadius = 15
                        self.present(alert, animated: true)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            alert.dismiss(animated: true)
                        }
                    }
                
                }
                
            })
        }
        
       
        
    }
}



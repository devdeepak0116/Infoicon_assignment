//
//  ProductListViewModel.swift
//  InfoiconAssignment
//
//  Created by Deepak's Mac on 07/03/23.
//

import Foundation
import UIKit



class ProductListViewModel : NSObject{
    var deleteId = ""
    var model : [ProductListData?] = []
    var controller = ProductListController()
    enum RequestType : String {
      case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
       
    }
    
    var tableView = UITableView()
    
    func callRequest(whichApiCall : String ,completion: @escaping (Bool) -> ()){
        
        let session = URLSession(configuration: .default)
        var requestType : RequestType
        requestType = .GET
        var baseUrl = "https://fakestoreapi.com/products/"
        var request = URLRequest(url: URL(string:baseUrl)!)
        
        if whichApiCall == "DeleteProduct"{
            requestType = .DELETE
            let url = "\(baseUrl)\(self.deleteId)"
            request = URLRequest(url: URL(string: url)!)
            
        }else if whichApiCall == "GetProductList"{
            requestType = .GET
            request = URLRequest(url: URL(string: baseUrl)!)
        }
        print(requestType.rawValue)
        print(request)
            request.httpMethod = requestType.rawValue
   
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            do {
     
                if whichApiCall == "GetProductList"{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                          print("Response: \(json)")
                    }
                    
                    let result = try? JSONDecoder().decode([ProductListData].self, from: data!)
                    self.model = result!
                    
                }else if whichApiCall == "DeleteProduct"{
                    print(response!)
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                          print("Response: \(json)")
                    }
                    
}
                
                completion(true)
                
            } catch {
                print("error1")
                
            }
        })

        task.resume()
    }
}

extension ProductListViewModel : UITableViewDataSource , UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProductListTableViewCell.identifier) as? ProductListTableViewCell{
            cell.title.text = model[indexPath.row]?.title
            cell.title.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.price.text = String(format: "%.2f",model[indexPath.row]?.price as! CVarArg)
            cell.rating.text = String(format: "%.1f",model[indexPath.row]?.rating.rate as! CVarArg)
            
            let url = URL(string: model[indexPath.row]?.image ?? "")
            let data1 = try? Data(contentsOf: url!)
            cell.productImage.image = UIImage(data: data1! )
            
            cell.deleteCall = {data in
                self.deleteId = "\(self.model[indexPath.row]?.id ?? 0)"
                
                let alert = UIAlertController(title: "Delete", message: "Are you sure, you want to delete this product",preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: { _ in
                           //Cancel Action
                       }))
                       alert.addAction(UIAlertAction(title: "Delete",
                                                     style: UIAlertAction.Style.default,
                                                     handler: {(_: UIAlertAction!) in
                                                       
                           self.callRequest(whichApiCall: "DeleteProduct",completion: { data in
                               if data{
                                   self.callRequest(whichApiCall: "GetProductList", completion: {data in
                                       if data{
                                           DispatchQueue.main.async {
                                               DispatchQueue.main.async {
                                                   let alert = UIAlertController(title: nil, message: "Product Deleted successfully", preferredStyle: .alert)
                                                   //alert.view.backgroundColor = UIColor.
                                                   alert.view.alpha = 0.5
                                                   alert.view.layer.cornerRadius = 15
                                                   self.controller.present(alert, animated: true)
                                                   DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                                                       alert.dismiss(animated: true)
                                                   }
                                               }
                                               self.tableView.reloadData()
                                               
                                           }
                                           
                                       }
                                       
                                   })
                               }
                           })

                       }))
                self.controller.present(alert, animated: true, completion: {})
                
                
         
            }
            cell.viewCall = {data in
                
                let nav = self.controller.storyboard?.instantiateViewController(withIdentifier: "ViewProductController") as! ViewProductController
                nav.productId = "\(self.model[indexPath.row]?.id ?? 0)"
                self.controller.navigationController?.pushViewController(nav, animated: true)
                
            }

            return cell
        }else{
            return UITableViewCell()
        }
        
    }
    
}

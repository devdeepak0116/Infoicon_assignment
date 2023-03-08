//
//  ProductDetailViewModel.swift
//  InfoiconAssignment
//
//  Created by Deepak's Mac on 08/03/23.
//

import Foundation
import UIKit



class ProductDetailViewModel : NSObject{
    var ProductId = ""
    var model : ProductViewData?
    var controller = ViewProductController()
    enum RequestType : String {
      case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
        case UPDATE = "UPDATE"
    }
    
    var tableView = UITableView()
    
    func callRequest(whichApiCall : String ,completion: @escaping (Bool) -> ()){
        
        let session = URLSession(configuration: .default)
        var requestType : RequestType
        requestType = .GET
        var baseUrl = "https://fakestoreapi.com/products/"
        var request = URLRequest(url: URL(string:baseUrl)!)
        
        if whichApiCall == "ViewProduct"{
            requestType = .GET
            let url = "\(baseUrl)\(self.ProductId)"
            request = URLRequest(url: URL(string: url)!)
            
        }else if whichApiCall == ""{
            requestType = .GET
            request = URLRequest(url: URL(string: baseUrl)!)
        }
        print(requestType.rawValue)
        print(request)
 
        request.httpMethod = requestType.rawValue
      
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            do {
     
                if whichApiCall == "ViewProduct"{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                          print("Response: \(json)")
                    }
                    
                    
                    let result = try? JSONDecoder().decode(ProductViewData.self, from: data!)
                    self.model = result!
                   
                }
                
                completion(true)
                
            } catch {
                print("error1")
                
            }
        })

        task.resume()
    }
}

extension ProductDetailViewModel : UITableViewDataSource , UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model != nil{
            return 1
        }else{
            return 0
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ViewProductTableViewCell.identifier) as? ViewProductTableViewCell{
            cell.title.text = model?.title
            cell.title.font = UIFont.boldSystemFont(ofSize: 17.0)
            cell.price.text = "Price : \(String(format: "%.2f",model?.price as! CVarArg))"
            cell.rate.text = "Rating : \(String(format: "%.1f",model?.rating.rate as! CVarArg))"
            cell.count.text = "\(model?.rating.count ?? 1)"
            cell.category.text = model?.category
            cell.desc.text = model?.description
            let url = URL(string: model?.image ?? "")
            let data1 = try? Data(contentsOf: url! )
            cell.prodImage.image = UIImage(data: data1! )
            
           
            return cell
        }else{
            return UITableViewCell()
        }
        
    }
    
}

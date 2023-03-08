//
//  AddEditViewModel.swift
//  InfoiconAssignment
//
//  Created by Deepak's Mac on 08/03/23.
//

import Foundation
import UIKit



class AddEditViewModel : NSObject{
    
    
    
    var id : Int = 0
    var title : String = ""
    var price : Double = 0.0
    var desc : String = ""
    var category : String = ""
    var image : String = ""
    var editId = ""
    
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
        
        if whichApiCall == "Add"{
            requestType = .POST
            let url = "\(baseUrl)"
            request = URLRequest(url: URL(string: url)!)
            
        }else if whichApiCall == "Edit"{
            requestType = .PUT
            let url = "\(baseUrl)\(self.editId)"
            request = URLRequest(url: URL(string: url)!)
           
        }
        print(requestType.rawValue)
        print(request)
        
        let params = ["title":"\(self.title)","price":"\(self.price)","description":"\(self.desc)",
                      "image":"\(self.image)","category":"\(self.category)"] as Dictionary<String, Any>

        
        request.httpMethod = requestType.rawValue
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print(request.httpBody)
        
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            do {
      
                if whichApiCall == "Add"{
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                          print("Response: \(json)")
                    }
                }else if whichApiCall == "Edit"{
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

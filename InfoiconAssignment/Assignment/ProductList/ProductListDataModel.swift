//
//  ProductListDataModel.swift
//  InfoiconAssignment
//
//  Created by Deepak's Mac on 07/03/23.
//

import Foundation


    struct ProductListData : Codable {
      
        var id : Int
        var title : String
        var price : Double
        var description : String
        var category : String
        var image : String
        var rating : Rating
        
        
  
    }

struct Rating : Codable {
    var rate : Double
    var count : Int
}



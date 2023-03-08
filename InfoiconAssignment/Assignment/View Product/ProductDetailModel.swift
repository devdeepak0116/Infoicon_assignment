//
//  ProductDetailModel.swift
//  InfoiconAssignment
//
//  Created by Deepak's Mac on 08/03/23.
//

import Foundation
struct ProductViewData : Codable {
  
    var id : Int
    var title : String
    var price : Double
    var description : String
    var category : String
    var image : String
    var rating : Ratedata
    

}

struct Ratedata : Codable {
var rate : Double
var count : Int
}

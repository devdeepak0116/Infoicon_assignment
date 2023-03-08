//
//  ProductListTableViewCell.swift
//  InfoiconAssignment
//
//  Created by Deepak's Mac on 07/03/23.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    
    
    var deleteCall:((_ Data:Bool)->Void)?
    var viewCall:((_ Data:Bool)->Void)?

    
    @IBOutlet weak var viewBtn: UIButton!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
  
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static var nib:UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier:String{
        return String(describing : self)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func deleteBtnClicked(_ sender: Any) {
        deleteCall!(true)
    }
    
    
    @IBAction func viewBtnClicked(_ sender: Any) {
      viewCall!(true)
    }
    

}

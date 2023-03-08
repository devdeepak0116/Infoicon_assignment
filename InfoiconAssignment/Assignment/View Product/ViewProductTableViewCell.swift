//
//  ViewProductTableViewCell.swift
//  InfoiconAssignment
//
//  Created by Deepak's Mac on 08/03/23.
//

import UIKit

class ViewProductTableViewCell: UITableViewCell {

    
    @IBOutlet weak var prodImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    
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
    
   
}

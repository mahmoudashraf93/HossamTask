//
//  HistoryCell.swift
//  zGO
//
//  Created by ZGO_MAC_3 on 12/26/16.
//  Copyright © 2016 Ahmed Khalil. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBAction func btnFavoritePressed(_ sender: AnyObject) {
        
        
    }
    @IBOutlet var lblDetails: UILabel!
    @IBOutlet var btnFavorite: UIButton!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var imgOwner: UIImageView!
    @IBOutlet var lblOwnerName: UILabel!
    @IBOutlet var imgItem: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  SummaryTableViewCell.swift
//  Homework2
//
//  Created by Gupta, Nidhi on 10/11/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet var smallImageView: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var developerName: UILabel!
   
    @IBOutlet var realeaseDate: UILabel!
    @IBOutlet var summary: UILabel!
    @IBOutlet var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

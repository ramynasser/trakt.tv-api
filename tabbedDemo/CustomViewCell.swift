//
//  CustomViewCell.swift
//  tabbedDemo
//
//  Created by Mohamed Farouk Code95 on 8/12/16.
//  Copyright © 2016 Mohamed Farouk Code95. All rights reserved.
//

import UIKit

class CustomViewCell: UITableViewCell {

    @IBOutlet weak var yeardetailLabel: UILabel!
    
    @IBOutlet weak var title_details_Label: UILabel!
    
    @IBOutlet weak var overview_details_label: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

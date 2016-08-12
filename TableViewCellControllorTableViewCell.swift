//
//  TableViewCellControllorTableViewCell.swift
//  
//
//  Created by Mohamed Farouk Code95 on 8/12/16.
//
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titlLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
 @ IBOutlet weak var YearLabel: UILabel!
    
    
    @IBOutlet weak var overViewLabel: UILabel!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  MapTableViewCell.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/20/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit

class MapTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mapIcon: UIImageView!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentLinkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  TextTableViewCell.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 20.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    
    @IBOutlet weak var textNews: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

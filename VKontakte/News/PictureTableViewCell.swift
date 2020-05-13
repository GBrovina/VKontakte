//
//  PictureTableViewCell.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 20.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit

class PictureTableViewCell: UITableViewCell {

    
    @IBOutlet weak var photoNews: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoNews.layer.cornerRadius = 7
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

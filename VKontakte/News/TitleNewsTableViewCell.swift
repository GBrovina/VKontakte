//
//  TitleNewsTableViewCell.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 20.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit

class TitleNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var shadow: UIView!
    
    @IBOutlet weak var pictureOfNews: UIImageView!
    
    @IBOutlet weak var nameOfNews: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pictureOfNews.layer.cornerRadius = pictureOfNews.frame.height/2

        
        shadow.layer.cornerRadius = shadow.frame.height/2
        shadow.layer.shadowOffset = .zero
        shadow.layer.shadowRadius = 5
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOpacity = 0.7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

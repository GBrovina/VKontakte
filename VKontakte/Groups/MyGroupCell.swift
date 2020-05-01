//
//  MyGroupCell.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 08.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit

class MyGroupCell: UITableViewCell {

    
    
    @IBOutlet weak var myGroupImage: UIImageView!
    
    @IBOutlet weak var myGroupName: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myGroupImage.layer.cornerRadius = myGroupImage.frame.height/2

        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

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
    
    @IBOutlet weak var heightConstraintImage: NSLayoutConstraint!
    
//    func setImage(image:UIImage?){
//        
//        guard let image = image else {return}
//        photoNews.image = image
//        
//        let coeff = frame.width/image.size.width
//        heightConstraintImage.constant = coeff*image.size.height
//        
//    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

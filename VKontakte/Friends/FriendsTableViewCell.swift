//
//  FriendsTableViewCell.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 08.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageFriends: UIImageView!
    
    
    @IBOutlet weak var friendsName: UILabel!
    
    
    @IBOutlet weak var shadow: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageFriends.layer.cornerRadius = imageFriends.frame.height/2

        
        shadow.layer.cornerRadius = shadow.frame.height/2
        shadow.layer.shadowOffset = .zero
        shadow.layer.shadowRadius = 5
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOpacity = 0.7
        
        
        
        
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        avatarAnimatied()
        // Configure the view for the selected state
    }
    

    func avatarAnimatied(){
      let animation = CASpringAnimation(keyPath: "transform.scale")
      animation.fromValue = 0
      animation.toValue = 1
      animation.stiffness = 200
      animation.mass = 2
      animation.duration = 0.3
      animation.beginTime = CACurrentMediaTime()
      animation.fillMode = CAMediaTimingFillMode.backwards
      self.imageFriends.layer.add(animation, forKey: nil)
      self.shadow.layer.add(animation, forKey: nil)
    }
    
}

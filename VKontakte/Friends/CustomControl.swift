//
//  CustomControl.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 13.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import UIKit


class CustomControl:UIControl{
    
    public var isLiked: Bool = false
    
    var likeCount:UILabel!
    var likePic:UIImageView!
    var count:Int! = 0
    
    override init (frame:CGRect){
        super.init(frame:frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    private func setupView(){
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tapGR.numberOfTouchesRequired = 1
        addGestureRecognizer(tapGR)
        likeCount = UILabel(frame:CGRect(x: 100, y: 0, width: 10, height: 23))
        likeCount.text = String(count)
        likeCount.textColor = .black
        self.addSubview(likeCount)
        
        likePic = UIImageView(image: UIImage(named: "emptyLike")!)
        likePic.frame = CGRect(x: 70, y: 0, width: 20, height: 22)

        self.addSubview(likePic)
        
        
    }
   
//    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//
//              likeCount.textColor = UIColor.blue
//              likeCount.text = String(count+1)
//              likePic.image = UIImage(named: "fullLike")!
//
//              return true
//
//      }
    
    
    @objc func likeTapped(){
           isLiked.toggle()
           likePic.image = isLiked ? UIImage(named: "fullLike") : UIImage(named: "emptyLike")
           likeCount.textColor = isLiked ? .black : .blue
           if isLiked == true {
               
                   likeCount.text = String(count+1)
                   likeAnimatied()
                   
               
           } else {
                
                    likeCount.text = String(count)
                    likeAnimatiedDown()
                    
           }
           setNeedsDisplay()
           sendActions(for: .valueChanged)
           
       }
    
    func likeAnimatied(){
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 0.3
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        self.likePic.layer.add(animation, forKey: nil)
      }
    
    func likeAnimatiedDown(){
          let animation = CASpringAnimation(keyPath: "transform.scale")
          animation.fromValue = 1
          animation.toValue = 0
          animation.stiffness = 200
          animation.mass = 2
          animation.duration = 0.3
          animation.beginTime = CACurrentMediaTime()
          animation.fillMode = CAMediaTimingFillMode.backwards
          self.likePic.layer.add(animation, forKey: nil)
        }
}

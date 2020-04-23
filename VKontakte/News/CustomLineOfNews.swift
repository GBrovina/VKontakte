//
//  CustomLineOfNews.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 20.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import UIKit


class CustomLineOfNews:UIControl{
    
    public var isLiked: Bool = false
    
    var likeCount:UILabel!
    var likePic:UIImageView!
    var repost:UIImageView!
    var message:UIImageView!
    var repostCount:UILabel!
    var messageCount:UILabel!
    var countLike:Int! = 0
    var countRepost:Int! = 0
    var countMessage:Int! = 0
    
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
        likeCount = UILabel(frame:CGRect(x: 85, y: 10, width: 20, height: 23))
        likeCount.text = String(countLike)
        likeCount.textColor = .black
        self.addSubview(likeCount)
        
        likePic = UIImageView(image: UIImage(named: "emptyLike")!)
        likePic.frame = CGRect(x: 50, y: 10, width: 20, height: 23)

        self.addSubview(likePic)
        
        
        repost = UIImageView(image: UIImage(named: "repost")!)
        repost.frame = CGRect(x: 145, y: 10, width: 20, height: 23)

        self.addSubview(repost)
        
        message = UIImageView(image: UIImage(named: "message")!)
        message.frame = CGRect(x: 230, y: 10, width: 20, height: 23)

        self.addSubview(message)
        
        repostCount = UILabel(frame:CGRect(x: 170, y: 10, width: 20, height: 23))
        repostCount.text = String(countRepost)
        repostCount.textColor = .black
        self.addSubview(repostCount)
        
        messageCount = UILabel(frame:CGRect(x: 255, y: 10, width: 20, height: 23))
        messageCount.text = String(countMessage)
        messageCount.textColor = .black
        self.addSubview(messageCount)
        
    }
  
    @objc func likeTapped(){
           isLiked.toggle()
           likePic.image = isLiked ? UIImage(named: "fullLike") : UIImage(named: "emptyLike")
           likeCount.textColor = isLiked ? .black : .blue
           if isLiked == true {
               
                   likeCount.text = String(countLike+1)
               
               
           } else {
                
                    likeCount.text = String(countLike)
               
           }
           setNeedsDisplay()
           sendActions(for: .valueChanged)
           
       }
}

//
//  CustomIndicator.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 23.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import UIKit


class CustomIndicator:UIView{
    
    var dotOne: UIView!
    var dotTwo:UIView!
    var dotThree:UIView!
    
    override init (frame:CGRect){
        super.init(frame:frame)
        setupView()
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        
    }
   
    //MAKE dots
    func setupView(){
        
        dotOne = UIView(frame: CGRect(x: 50, y: 50, width: 10, height: 10))
        dotOne.layer.cornerRadius = dotOne.frame.height/2
        dotOne.backgroundColor = UIColor.lightGray
        addSubview(dotOne)
        
        dotTwo = UIView(frame: CGRect(x: 70, y: 50, width: 10, height: 10))
        dotTwo.layer.cornerRadius = dotOne.frame.height/2
        dotTwo.backgroundColor = UIColor.lightGray
        addSubview(dotTwo)
        
        dotThree = UIView(frame: CGRect(x: 90, y: 50, width: 10, height: 10))
        dotThree.layer.cornerRadius = dotOne.frame.height/2
        dotThree.backgroundColor = UIColor.lightGray
        addSubview(dotThree)
        
    }
    
    //MAKE animation
    func startAnimations(){
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: [.autoreverse,.curveEaseIn, .repeat],
                       animations: {
                       self.dotOne.alpha = 0.3
                        })
        UIView.animate(withDuration: 1.0,
                       delay: 0.3,
                       options: [.autoreverse,.curveEaseIn, .repeat],
                       animations: {
                       self.dotTwo.alpha = 0.3
                        })
        UIView.animate(withDuration: 1.0,
                       delay: 0.6,
                       options: [.autoreverse,.curveEaseIn, .repeat],
                       animations: {
                       self.dotThree.alpha = 0.3
                        })
    }
    
    
    func stopAnimation(){
        dotOne.layer.removeAllAnimations()
        dotTwo.layer.removeAllAnimations()
        dotThree.layer.removeAllAnimations()
        
    }
}

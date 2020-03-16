//
//  PhotoAlbum.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 26.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import UIKit

class PhotoAlbum: UIViewController {
    
    var selectedFriend:[UIImage] = []
    var numberOfSection:Int = 0
    
    
    @IBOutlet weak var additionalIV: UIImageView!
    @IBOutlet weak var photoOfFriends: UIImageView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard !selectedFriend.isEmpty else {return}
        self.photoOfFriends?.image = selectedFriend[numberOfSection]
        
//        НЕ работает свайп
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(photoSwipeLeft(_:)))
        photoOfFriends?.isUserInteractionEnabled = false
        swipeleft.delegate = self
        swipeleft.direction = .left
        photoOfFriends?.addGestureRecognizer(swipeleft)
        photoOfFriends?.isUserInteractionEnabled = true

        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(photoSwipeRight(_:)))
        
        swiperight.delegate = self
        swiperight.direction = .right
        photoOfFriends?.addGestureRecognizer(swiperight)
        photoOfFriends?.isUserInteractionEnabled = true
    }
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
//        photoOfFriends?.isUserInteractionEnabled  = true
//        photoOfFriends?.addGestureRecognizer(tap)
//    }
//
//    @objc func tap (_ tap:UITapGestureRecognizer) {
//           guard numberOfSection+1 <= selectedFriend.count-1 else {return}
//
//        additionalIV.transform = CGAffineTransform(translationX: 1.5*(self.photoOfFriends?.bounds.width)!, y: 200).concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
//        additionalIV.image = selectedFriend[numberOfSection+1]
//        UIView.animate(withDuration: 0.7,
//                       delay: 0,
//                       options: .curveEaseInOut,
//                       animations: {
//                        self.photoOfFriends!.transform = CGAffineTransform(translationX: -1.5*(self.photoOfFriends?.bounds.width)!, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
//                        self.additionalIV.transform = .identity
//
//        }) { _ in
//            self.numberOfSection += 1
//            self.photoOfFriends?.image = self.selectedFriend[self.numberOfSection]
//            self.photoOfFriends?.transform = .identity
//    }
//       }
    
//    НЕ Работает свайп
    @objc func photoSwipeLeft (_ swipe:UISwipeGestureRecognizer) {
        guard numberOfSection+1 <= selectedFriend.count-1 else {return}
        
        additionalIV.transform = CGAffineTransform(translationX: 1.5*(self.photoOfFriends?.bounds.width)!, y: 200).concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
                additionalIV.image = selectedFriend[numberOfSection+1]
                UIView.animate(withDuration: 0.7,
                               delay: 0,
                               options: .curveEaseInOut,
                               animations: {
                                self.photoOfFriends!.transform = CGAffineTransform(translationX: -1.5*(self.photoOfFriends?.bounds.width)!, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                                self.additionalIV.transform = .identity
        
                }) { _ in
                    self.numberOfSection += 1
                    self.photoOfFriends?.image = self.selectedFriend[self.numberOfSection]
                    self.photoOfFriends?.transform = .identity
            }
               }

    @objc func photoSwipeRight (_ swipe:UISwipeGestureRecognizer) {
          guard numberOfSection >= 1 else {return}
        
        additionalIV.transform = CGAffineTransform(translationX: -1.5*(self.photoOfFriends?.bounds.width)!, y: -200).concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
                      additionalIV.image = selectedFriend[numberOfSection-1]
                      UIView.animate(withDuration: 0.7,
                                     delay: 0,
                                     options: .curveEaseInOut,
                                     animations: {
                                      self.photoOfFriends!.transform = CGAffineTransform(translationX: 1.5*(self.photoOfFriends?.bounds.width)!, y: 100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                                      self.additionalIV.transform = .identity
              
                      }) { _ in
                          self.numberOfSection -= 1
                          self.photoOfFriends?.image = self.selectedFriend[self.numberOfSection]
                          self.photoOfFriends?.transform = .identity
                  }
                     }
}

extension PhotoAlbum : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

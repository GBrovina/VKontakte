//
//  PhotoAlbum.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 26.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import RealmSwift

class PhotoAlbum: UIViewController {
    
    
//   var selectedFriend:[UIImage] = []
    var numberOfSection:Int = 0
    
    var selectedFriends: Results<PhotoService>? 
    
    @IBOutlet weak var additionalIV: UIImageView!
    @IBOutlet weak var photoOfFriends: UIImageView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        guard !selectedFriends!.isEmpty else {return}
        if let url = URL(string:selectedFriends?[numberOfSection].userPhoto ?? ""),
        let data = try? Data(contentsOf: url){
            self.photoOfFriends?.image = UIImage(data:data)}
        

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

    @objc func photoSwipeLeft (_ swipe:UISwipeGestureRecognizer) {
        guard numberOfSection+1 <= selectedFriends?.count ?? 0-1 else {return}
        
        additionalIV.transform = CGAffineTransform(translationX: 1.5*(self.photoOfFriends?.bounds.width)!, y: 200).concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
        if let url = URL(string:selectedFriends?[numberOfSection+1].userPhoto ?? ""),
        let data = try? Data(contentsOf: url){
        additionalIV.image = UIImage(data:data)}
                UIView.animate(withDuration: 0.7,
                               delay: 0,
                               options: .curveEaseInOut,
                               animations: {
                                self.photoOfFriends!.transform = CGAffineTransform(translationX: -1.5*(self.photoOfFriends?.bounds.width)!, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                                self.additionalIV.transform = .identity
        
                }) { _ in
                    self.numberOfSection += 1
                    if let url = URL(string:self.selectedFriends?[self.numberOfSection].userPhoto ?? ""),
                    let data = try? Data(contentsOf: url){
                        self.photoOfFriends?.image = UIImage(data:data)}
                    self.photoOfFriends?.transform = .identity
            }
               }

    @objc func photoSwipeRight (_ swipe:UISwipeGestureRecognizer) {
          guard numberOfSection >= 1 else {return}
        
        additionalIV.transform = CGAffineTransform(translationX: -1.5*(self.photoOfFriends?.bounds.width)!, y: -200).concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
        if let url = URL(string:selectedFriends?[numberOfSection-1].userPhoto ?? ""),
        let data = try? Data(contentsOf: url){
        additionalIV.image = UIImage(data:data)}
        
                      UIView.animate(withDuration: 0.7,
                                     delay: 0,
                                     options: .curveEaseInOut,
                                     animations: {
                                      self.photoOfFriends!.transform = CGAffineTransform(translationX: 1.5*(self.photoOfFriends?.bounds.width)!, y: 100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                                      self.additionalIV.transform = .identity
              
                      }) { _ in
                          self.numberOfSection -= 1
                        
                        if let url = URL(string:self.selectedFriends?[self.numberOfSection].userPhoto ?? ""),
                          let data = try? Data(contentsOf: url){
                              self.photoOfFriends?.image = UIImage(data:data)}
                          self.photoOfFriends?.transform = .identity
                  }
                     }
}

extension PhotoAlbum : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

//
//  FriendsCollectionViewController.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 10.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class FriendsCollectionViewController: UICollectionViewController {
    let photoService = VKService()
    var photo  = [PhotoService]()
    var userId:Int = 0
    
//      var imagePage:UIImage?
      var photoAlbum = [UIImage]()
     


    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoService.photoOfPerson(userId){
            self.loadData()
            self.collectionView.reloadData()
        }
        
//        photoService.photoOfPerson(userId) { [weak self] responce in
//            guard let self = self else {return}
//            switch responce{
//            case .success(let photo):
//                self.photo = photo
//                self.collectionView.reloadData()
//            case .failure(let error):
//                print(error.localizedDescription)
//        }
//        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    func loadData(){
           do{
               let realm = try Realm()
               let photos = realm.objects(PhotoService.self)
               photo = Array(photos)
               
           }
           catch{
               print (error.localizedDescription)
           }
       }
       
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "photoOfFriendsSegue" {
         guard let viewController = segue.destination as? PhotoAlbum,
            let bigPhoto = collectionView.indexPathsForSelectedItems?.first
             else {return}
        
            viewController.selectedFriends = photo
            viewController.numberOfSection = bigPhoto.item
            collectionView.deselectItem(at: bigPhoto, animated: true)
            
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photo.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Photo", for: indexPath) as? FriendsCollectionViewCell
        let photoAlbumService:PhotoService = photo[indexPath.item]
        if let url = URL(string:photoAlbumService.userPhoto),
        let data = try? Data(contentsOf: url){
            cell?.friendsPhoto.image = UIImage(data: data)}
//        cell?.friendsPhoto.image = photoAlbum[indexPath.item]
    
        // Configure the cell
    
        return cell!
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

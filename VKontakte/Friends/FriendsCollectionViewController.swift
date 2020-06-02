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
    var userId:Int = 0
    var photo: Results<PhotoService>?
    var token:[NotificationToken] = []
    
    lazy var photoCache = PhotoCache(collection: self.collectionView)

    
    var photoAlbum = [UIImage]()
     
    func observePhoto(){
        guard let realm = try? Realm() else {return}
        photo = realm.objects(PhotoService.self)
        photo?.observe{[weak self](changes) in
            switch changes{
                          case .initial:
                              self?.collectionView.reloadData()
                          case .update(_,let deletions,let insertions,let modifications):
                              self?.collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                              self?.collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
                              self?.collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                          case .error(let error):
                              print (error.localizedDescription)
                            }
                    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        photoService.photoOfPerson(userId)
        observePhoto()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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
        return photo?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Photo", for: indexPath) as? FriendsCollectionViewCell
        let photoAlbumService = try? (photo?[indexPath.item])
        
//        if let url = URL(string:photoAlbumService.userPhoto),
//        let data = try? Data(contentsOf: url){
            
//            cell?.friendsPhoto.image = UIImage(data: data)
            
//        }
        cell?.friendsPhoto.image = photoCache.photo(indexPath: indexPath, at: photoAlbumService?.userPhoto ?? "")
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

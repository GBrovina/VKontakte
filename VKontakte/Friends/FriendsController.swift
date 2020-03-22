//
//  FriendsTableViewController.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 08.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit
import SwiftyJSON

class FriendsTableViewController: UITableViewController {

    let friendsService = VKService()
    var friend = [Friends]()
    
//   public var friend = [Friends(userName:"Fox", avatar:UIImage(named:"fox")!, photos:[UIImage(named:"fox")!,UIImage(named:"fox")!,UIImage(named:"fox")!,UIImage(named:"fox")!]), Friends(userName:"Lion",avatar:UIImage(named:"Lion")!,photos:[UIImage(named:"Lion")!,UIImage(named:"Lion")!,UIImage(named:"Lion")!,UIImage(named:"Lion")!]), Friends(userName:"Pingvin",avatar:UIImage(named:"pigvin")!,photos:[UIImage(named:"pigvin")!,UIImage(named:"pigvin")!,UIImage(named:"pigvin")!]), Friends(userName:"Cow",avatar:UIImage(named:"cow")!,photos:[UIImage(named:"cow")!]), Friends(userName:"Cock",avatar:UIImage(named:"cock")!,photos:[UIImage(named:"Cock_2")!,UIImage(named:"cock_3")!,UIImage(named:"Cock_2")!,UIImage(named:"cock")!]), Friends(userName:"Leopard",avatar:UIImage(named:"leopard")!,photos:[UIImage(named:"leopard")!,UIImage(named:"leopard")!,UIImage(named:"leopard")!,UIImage(named:"leopard")!])]
    
    var sortiedFriends = [Character:[Friends]]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsService.listOfFriends { [weak self] responce in
            guard let self = self else {return}
            switch responce{
            case .success(let friend):
                self.friend = friend
                self.sortiedFriends = sort(friend:friend)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
        }
        }
        func sort(friend:[Friends]) -> [Character:[Friends]] {
              var namesDict = [Character:[Friends]]()
              
              friend
                  .sorted {$0.userName < $1.userName}
                  .forEach { friend in
                      guard let firstChar = friend.userName.first else {return}
                      if var thisCharName = namesDict[firstChar] {
                          thisCharName.append(friend)
                          namesDict[firstChar] = thisCharName
                      } else {
                          namesDict[firstChar] = [friend]
                      }
                      
              }
              return namesDict
          }
//        self.sortiedFriends = sort(friend:friend)
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sortiedFriends.keys.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let firstChar = sortiedFriends.keys.sorted()[section]
        return String(firstChar)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let keySorted = sortiedFriends.keys.sorted()
        return sortiedFriends[keySorted[section]]?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Friends", for: indexPath) as! FriendsTableViewCell
        let firstChar = sortiedFriends.keys.sorted()[indexPath.section]
        let friend = sortiedFriends[firstChar]!
        let name:Friends = friend[indexPath.row]
    
        
        cell.friendsName.text=name.userName
        
        if let url = URL(string:name.avatar),
            let data = try? Data(contentsOf: url){
            cell.imageFriends.image=UIImage(data:data)}
        

        // Configure the cell...

        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "pageOfFriends" {
            guard let collectionViewController = segue.destination as? FriendsCollectionViewController,
//                let cell = sender as? FriendsTableViewCell,
                let selectedCell = tableView.indexPathForSelectedRow
                else {return}
            
            let firstChar = sortiedFriends.keys.sorted()[selectedCell.section]
            let friend = sortiedFriends[firstChar]!
            let name:Friends = friend[selectedCell.row]
            let userId = name.userId
            collectionViewController.userId = userId
            collectionViewController.title = name.userName
//            collectionViewController.photoAlbum = name.photos
            
        }
    }
}

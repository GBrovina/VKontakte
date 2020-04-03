//
//  FriendsTableViewController.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 08.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class FriendsTableViewController: UITableViewController {

    let friendsService = VKService()
//    var friend = [Friends]()
//    var sortiedFriends = [Character:[Friends]]()

    var sections:[Results<Friends>] = []
    var tokens:[NotificationToken] = []
    
    func prerareSection() {
        do{
           let realm = try Realm()
            let friendsLetters = Array(Set(realm.objects(Friends.self).compactMap{$0.userName.first?.lowercased()})).sorted()
            sections = friendsLetters.map{realm.objects(Friends.self).filter("userName BEGINSWITH[c] %s",$0)}
            sections.enumerated().forEach{observeFriends(for: $0.offset, results: $0.element)}
            tokens.removeAll()
            tableView.reloadData()
        }
        catch {
            print (error.localizedDescription)
        }
    }
    
    func observeFriends(for section:Int, results: Results<Friends>){
        tokens.append(
               results.observe { (changes) in
                   switch changes{
                   case .initial:
                    self.tableView.reloadSections(IndexSet(integer:section), with: .automatic)
                   case .update(_,let deletions,let insertions,let modifications):
                       self.tableView.beginUpdates()
                       self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: section) }),with: .automatic)
                       self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: section)}), with: .automatic)
                       self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: section) }),with: .automatic)
                       self.tableView.endUpdates()
                   case .error(let error):
                       print (error.localizedDescription)
                   }
               })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prerareSection()
//        friendsService.listOfFriends{
//            self.loadData()
//            self.sortiedFriends = sort(friend: self.friend)
//            self.tableView.reloadData()
//        }
        
//        friendsService.listOfFriends { [weak self] responce in
//            guard let self = self else {return}
//            switch responce{
//            case .success(let friend):
//                self.friend = friend
//                self.sortiedFriends = sort(friend:friend)
//                self.tableView.reloadData()
//            case .failure(let error):
//                print(error.localizedDescription)
//        }
//        }
//        func sort(friend:[Friends]) -> [Character:[Friends]] {
//              var namesDict = [Character:[Friends]]()
//
//              friend
//                  .sorted {$0.userName < $1.userName}
//                  .forEach { friend in
//                      guard let firstChar = friend.userName.first else {return}
//                      if var thisCharName = namesDict[firstChar] {
//                          thisCharName.append(friend)
//                          namesDict[firstChar] = thisCharName
//                      } else {
//                          namesDict[firstChar] = [friend]
//                      }
//
//              }
//              return namesDict
//          }
//        self.sortiedFriends = sort(friend:friend)
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

//    func loadData(){
//        do{
//            let realm = try Realm()
//            let friends = realm.objects(Friends.self)
//            friend = Array(friends)
//
//        }
//        catch{
//            print (error.localizedDescription)
//        }
//    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
//        return sortiedFriends.keys.count
        return sections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let firstChar = sortiedFriends.keys.sorted()[section]
//        return String(firstChar)
        return sections[section].first?.userName.first?.uppercased()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        let keySorted = sortiedFriends.keys.sorted()
//        return sortiedFriends[keySorted[section]]?.count ?? 0
        return sections[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Friends", for: indexPath) as! FriendsTableViewCell
//        let firstChar = sortiedFriends.keys.sorted()[indexPath.section]
//        let friend = sortiedFriends[firstChar]!
        
//        let name:Friends = friend[indexPath.row]
    
        let name = sections[indexPath.section][indexPath.row]
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
            
//            let firstChar = sortiedFriends.keys.sorted()[selectedCell.section]
//            let friend = sortiedFriends[firstChar]!
            let name:Results<Friends> = sections[selectedCell.section]
            
            collectionViewController.userId = name[selectedCell.row].userId
            collectionViewController.title = name[selectedCell.row].userName
//            collectionViewController.photoAlbum = name.photos
            
        }
    }
}

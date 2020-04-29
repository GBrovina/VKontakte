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
import FirebaseAuth

class FriendsTableViewController: UITableViewController {

    let friendsService = VKService()
    var sections:[Results<Friends>] = []
    var tokens:[NotificationToken] = []
    
    let myQueue = OperationQueue()
    let reqest = VKService().reqestForOperation()
    
    
    @IBAction func logOut(_ sender: Any) {
        do {
               try Auth.auth().signOut()
               self.dismiss(animated: true, completion: nil)
           } catch (let error) {
               
               print("Auth sign out failed: \(error)")
           }

    }
    
    
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
//        friendsService.listOfFriends()
        
        let dataOperation = GetDataOperation(request: reqest)
        self.myQueue.addOperation(dataOperation)
        let parse = ParseData()
        parse.addDependency(dataOperation)
        self.myQueue.addOperation(parse)
        self.tableView.reloadData()
        
    }


    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return sections[section].first?.userName.first?.uppercased()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Friends", for: indexPath) as! FriendsTableViewCell

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
            
            let name:Results<Friends> = sections[selectedCell.section]
            
            collectionViewController.userId = name[selectedCell.row].userId
            collectionViewController.title = name[selectedCell.row].userName
        }
    }
}

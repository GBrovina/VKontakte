//
//  NewsTableViewController.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 20.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit
import RealmSwift

class NewsTableViewController: UITableViewController {

    let myGroupService = VKService()
//    var myGroup = [MyGroup]()
    var myNews:Results<News>?
    var token:[NotificationToken] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observNews()
        myGroupService.listOfNews()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    // MARK: - ObservNews
    func observNews() {
        do{
            guard let realm = try? Realm() else {return}
            myNews = realm.objects(News.self)
            myNews?.observe { (changes) in
                switch changes{
                case .initial:
                    self.tableView.reloadData()
                case .update(_,let deletions,let insertions,let modifications):
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),with: .automatic)
                    self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),with: .automatic)
                    self.tableView.endUpdates()
                case .error(let error):
                    print (error.localizedDescription)
                }
            }
        } catch{
            print (error.localizedDescription)
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return myNews?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleNews", for: indexPath) as! TitleNewsTableViewCell
            
            guard let sourecID = myNews?[indexPath.section].sourceId else {return UITableViewCell()}
            if sourecID>0{
                do{
                    
                    let realm = try Realm()
                    let name = realm.object(ofType: Friends.self, forPrimaryKey: sourecID)
                    cell.nameOfNews.text = name?.userName
                    DispatchQueue.main.async {
                    if let url = URL(string:name?.avatar ?? ""),
                    let data = try? Data(contentsOf: url){
                        cell.pictureOfNews.image = UIImage(data:data)}}
                    
                } catch {
                    print(error.localizedDescription)
                }
                
            } else {
                do{
                    let realm = try Realm()
                    let name = realm.object(ofType: MyGroup.self, forPrimaryKey: -sourecID)
                    cell.nameOfNews.text = name?.groupName
                    DispatchQueue.main.async {
                    if let url = URL(string:name?.imageGroup ?? ""),
                    let data = try? Data(contentsOf: url){
                    cell.pictureOfNews.image = UIImage(data:data)}
                    }
                } catch {
                    print(error.localizedDescription)
                    }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textNews", for: indexPath) as! TextTableViewCell
            let textNews = myNews?[indexPath.section]
            cell.textNews.text = textNews?.textNews
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "pictureNews", for: indexPath) as! PictureTableViewCell
            let name = myNews?[indexPath.section]
            
            DispatchQueue.main.async {
            if let url = URL(string:name?.photoNews ?? ""),
            let data = try? Data(contentsOf: url){
            cell.photoNews.image = UIImage(data:data)}
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "likeNews", for: indexPath) as! LikesTableViewCell
            guard let likeCount = myNews?[indexPath.section].likeCount,
                let repostCount = myNews?[indexPath.section].repostCount,
                let messageCount = myNews?[indexPath.section].messageCount
                else {return UITableViewCell()}
            
            cell.likeNews.countLike = likeCount
            cell.likeNews.countMessage = messageCount
            cell.likeNews.countRepost = repostCount
            return cell
        default:
            return UITableViewCell()

        // Configure the cell...
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

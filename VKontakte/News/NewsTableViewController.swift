//
//  NewsTableViewController.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 20.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

//    var myGroup = [MyGroup(groupName:"Art",imageGroup:UIImage(named:"art")!),
//                   MyGroup(groupName:"Forest",imageGroup:UIImage(named:"Forest")!) ]
    var myGroup = [MyGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return myGroup.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleNews", for: indexPath) as! TitleNewsTableViewCell
            let name = myGroup[indexPath.section]
            cell.nameOfNews.text = name.groupName
            cell.pictureOfNews.image = UIImage(named:name.imageGroup)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textNews", for: indexPath) as! TextTableViewCell
            cell.textNews.text = "A forest is a large area dominated by trees. Hundreds of more precise definitions of forest are used throughout the world, incorporating factors such as tree density, tree height, land use, legal standing and ecological function."
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "pictureNews", for: indexPath) as! PictureTableViewCell
            let name = myGroup[indexPath.section]
            cell.photoNews.image = UIImage(named:name.imageGroup)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "likeNews", for: indexPath) as! LikesTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "likeNews", for: indexPath) as! LikesTableViewCell
            return cell

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

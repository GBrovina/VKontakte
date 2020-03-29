//
//  MyGroupController.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 08.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit
import RealmSwift

class MyGroupController: UITableViewController {

    let myGroupService = VKService()
    var myGroup = [MyGroup]()
    
//    var myGroup = [MyGroup(groupName:"Art",imageGroup:UIImage(named:"art")!),
//                   MyGroup(groupName:"Forest",imageGroup:UIImage(named:"Forest")!) ]
    
    private var fitredGroups = [MyGroup]()
    
    
    @IBOutlet weak var searchGroup: UISearchBar! {
        didSet{
            searchGroup.delegate = self
        }
    }
    
    
    
    @IBAction func addGroup (segue:UIStoryboardSegue) {
        if segue.identifier == "unGroups"{
            let groupController = segue.source as! GroupController
            if let indexPath = groupController.tableView.indexPathForSelectedRow{
                let group = groupController.myGroup[indexPath.row]
                
                if !fitredGroups.contains(where: {$0.groupName==group.groupName}) {
                fitredGroups.append(group)
                tableView.reloadData()
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myGroupService.listOfGroup {
            self.loadData()
            self.fitredGroups = self.myGroup
            self.tableView.reloadData()
        }
//        myGroupService.listOfGroup { [weak self] responce in
//                   guard let self = self else {return}
//                   switch responce{
//                   case .success(let myGroup):
//                    self.loadData()
////                    self.myGroup = myGroup
//                    self.fitredGroups = myGroup
//                       self.tableView.reloadData()
//                   case .failure(let error):
//                       print(error.localizedDescription)
//               }
//               }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        fitredGroups = myGroup
    }
    
    func loadData(){
        do{
            let realm = try Realm()
            let groups = realm.objects(MyGroup.self)
            myGroup = Array(groups)
            
        }
        catch{
            print (error.localizedDescription)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fitredGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroup", for: indexPath) as! MyGroupCell
        
        
        let name = fitredGroups[indexPath.row]
        if let url = URL(string:name.imageGroup),
        let data = try? Data(contentsOf: url){
            cell.myGroupImage.image = UIImage(data:data)}
        cell.myGroupName.text = name.groupName

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

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            myGroup.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
    extension MyGroupController:UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty{
                fitredGroups = myGroup
                tableView.reloadData()
            } else {
                fitredGroups = myGroup.filter {$0.groupName.contains(searchText)}
                tableView.reloadData()
            }
        }
    }
    
    
    


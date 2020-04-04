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
//    var myGroup = [MyGroup]()
    var myGroup:Results<MyGroup>?
    var token:[NotificationToken] = []
    
    private var fitredGroups:Results<MyGroup>?
    
    
    @IBOutlet weak var searchGroup: UISearchBar! {
        didSet{
            searchGroup.delegate = self
        }
    }
    
    
//    MARK: - IBAction AddGroup
    

    @IBAction func addGroup(_ sender: UITabBarItem) {
        showAddCityForm()
    }

    func showAddCityForm() {
        let alertController = UIAlertController(title: "Введите название группы", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let confirmAction = UIAlertAction(title: "Добавить", style: .default) { action in
            guard let name = alertController.textFields?[0].text else { return }
            let cleared = name.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if !cleared.isEmpty {
                self.addGroup(name: name)
            }
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func addGroup ( name:String){
        do{
                   let realm = try Realm()
                   let Newgroups = MyGroup()
                   Newgroups.groupName = name
                   realm.beginWrite()
                   realm.add(Newgroups)
                   try realm.commitWrite()
               }
               catch{
                   print (error.localizedDescription)
               }
    }

    func observGroup() {
        do{
            guard let realm = try? Realm() else {return}
            myGroup = realm.objects(MyGroup.self)
            fitredGroups = myGroup
            myGroup?.observe { (changes) in
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observGroup()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return fitredGroups?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroup", for: indexPath) as! MyGroupCell
        
        
        let name = myGroup?[indexPath.row]
        if let url = URL(string:name?.imageGroup ?? ""),
        let data = try? Data(contentsOf: url){
            cell.myGroupImage.image = UIImage(data:data)}
        cell.myGroupName.text = name?.groupName

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
        let group = myGroup?[indexPath.row]
        if editingStyle == .delete {
            do{
                let realm = try Realm()
                realm.beginWrite()
                realm.delete(group!)
                try realm.commitWrite()
                
            }catch{
                print (error.localizedDescription)
            }
            // Delete the row from the data source
//            myGroup.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
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
            } else {
            do{
                let realm = try Realm()
                let searchingGroups = realm.objects(MyGroup.self).filter("groupName CONTAINS[cd] %@",searchText)
                fitredGroups = searchingGroups
                token.removeAll()
                tableView.reloadData()
            }catch{
                print (error.localizedDescription)
                }
            }

       }
    }
    
    
    


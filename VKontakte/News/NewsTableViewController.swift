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

    let myNewsService = VKService()
    var myNews:Results<News>?
    var token:NotificationToken?
    private var startFrom:String = ""
    private var loading:Bool = false
    var fullText = Set<IndexPath>()
    weak var delegate:TextTableViewCellDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.prefetchDataSource = self
        loading = true
        myNewsService.listOfNews(startFrom: ""){[weak self] startFrom in
            self?.startFrom = startFrom
            DispatchQueue.main.async{
                self?.tableView.reloadData()
                self?.loading = false
            }
        }
        prepareSection()
       
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        
     
            
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 4
     

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - PrepareSection
    func prepareSection(){
        do{
            guard let realm = try? Realm() else {return}
            myNews = realm.objects(News.self)
            observNews()
            tableView.reloadData()
        } catch{
            print (error.localizedDescription)
        }
    }
    
    
    // MARK: - ObservNews
    func observNews() {
            token = myNews?.observe { [weak self] (changes) in
                          switch changes{
                          case .initial:
                              self?.tableView.reloadData()
                          case .update(_,let deletions,let insertions,let modifications):
                              self?.tableView.beginUpdates()
                              self?.tableView.insertSections(.init(insertions), with: .automatic)
                              self?.tableView.deleteSections(.init(deletions), with: .automatic)
                              self?.tableView.reloadSections(.init(modifications), with: .automatic)
                              self?.tableView.endUpdates()
                          case .error(let error):
                              print (error.localizedDescription)
                        }
            }
    }
    
    // MARK: - Selector for refresh
    
    @objc func refreshNews() {
        
        myNewsService.listOfNews(startFrom: "") {[weak self] _ in
            DispatchQueue.main.async{
            self?.refreshControl?.beginRefreshing()
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
        }
        }
        
    }
    
    // MARK: - cellPrototype
    func cellPrototype (news:News, indexPath:IndexPath) -> UITableViewCell {

            if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "titleNews", for: indexPath) as! TitleNewsTableViewCell
                    
                    guard let sourecID = myNews?[indexPath.section].sourceId else {return UITableViewCell()}
                    
                    if sourecID>0{
                        do{
                            
                            let realm = try Realm()
                            let name = realm.object(ofType: Friends.self, forPrimaryKey: sourecID)
                            DispatchQueue.main.async {
                            cell.nameOfNews.text = name?.userName
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
                            DispatchQueue.main.async {
                            cell.nameOfNews.text = name?.groupName
                            if let url = URL(string:name?.imageGroup ?? ""),
                            let data = try? Data(contentsOf: url){
                            cell.pictureOfNews.image = UIImage(data:data)}
                            }
                        } catch {
                            print(error.localizedDescription)
                            }
                    }
                    return cell
            } else if (indexPath.row == 1 && news.hasText && news.hasImage) || (!news.hasImage && news.hasText && indexPath.row == 1) {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "textNews", for: indexPath) as! TextTableViewCell
                    cell.indexPath = indexPath
                    cell.delegate = self
                
                if fullText.contains(indexPath){
                    cell.showMoreButton.setTitle("Show less", for: .normal)
                    guard let textNews = myNews?[indexPath.section] else {return UITableViewCell()}
                    DispatchQueue.main.async {
                        cell.textNews.text = textNews.textNews
                        cell.textNewsHeight.constant = 120
                    }
                } else {
                    cell.showMoreButton.setTitle("Show more", for: .normal)
                    guard let textNews = myNews?[indexPath.section] else {return UITableViewCell()}
                    cell.hiddenButton()
                    DispatchQueue.main.async {
                        cell.textNews.text = textNews.textNews
                        cell.textNewsHeight.constant = 50
                    }
                }
                    return cell
            } else if (indexPath.row == 2 && news.hasText && news.hasImage) || (!news.hasText && news.hasImage && indexPath.row == 1) {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "pictureNews", for: indexPath) as! PictureTableViewCell
                    guard let name = myNews?[indexPath.section] else {return UITableViewCell()}
                    
                    DispatchQueue.main.async {
                    if let url = URL(string:name.photoNews),
                    let data = try? Data(contentsOf: url){
                        cell.photoNews.image =  UIImage(data:data)
                        }
                    }
                    return cell
            } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "likeNews", for: indexPath) as! LikesTableViewCell
                    guard let likeCount = myNews?[indexPath.section].likeCount,
                        let repostCount = myNews?[indexPath.section].repostCount,
                        let messageCount = myNews?[indexPath.section].messageCount
                        else {return UITableViewCell()}
                    DispatchQueue.main.async {
                    cell.likeNews.countLike = likeCount
                    cell.likeNews.countMessage = messageCount
                    cell.likeNews.countRepost = repostCount
                    }
                    return cell
            }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return myNews?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = myNews?[section] else {return 0}
        if section.hasImage && section.hasText {
            return 4
        } else if (!section.hasImage && section.hasText) || (!section.hasText && section.hasImage) {
            return 3
        } else {
            return 2
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = myNews![indexPath.section]
      
        let cell = cellPrototype(news: news, indexPath: indexPath)
        
            return cell
      
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2, let news = myNews?[indexPath.section], news.hasImage
        {return tableView.bounds.size.width*news.aspetRatio
            
        }else if indexPath.row == 1, let news = myNews?[indexPath.section], news.hasText
        {
            return 120
            
        } else {
            return UITableView.automaticDimension
        }
        
    }
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
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

extension NewsTableViewController:UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard !loading,
            let maxSection = indexPaths.map(\.section).max(), let section = myNews, maxSection > section.count - 4 else {return}
        loading = true
        myNewsService.listOfNews(startFrom: ""){[weak self] startFrom in
            self?.startFrom = startFrom
            self?.loading = false
        }
    }
}


extension NewsTableViewController:TextTableViewCellDelegate{
    func showMoreTapped(indexPath: IndexPath) {
        if fullText.contains(indexPath){
            fullText.remove(indexPath)
        } else {
            fullText.insert(indexPath)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
}

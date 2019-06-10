//
//  ViewController.swift
//  DataViewApp
//
//  Created by Thyago on 07/06/19.
//  Copyright © 2019 tcasablancas. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var aRepos = [RepoData]()
    var refreshControl = UIRefreshControl()
    let urlString = "https://api.github.com/search/repositories?q=language:swift&sort=stars"
    //let urlString = "https://api.github.com/repositories"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.separatorStyle = .none
        self.tableview.rowHeight = 50.0
        
        refreshControl.attributedTitle = NSAttributedString(string: "Aguarde!")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tableview.addSubview(refreshControl)
    }
    
    func getData() {
        
        let url = URL(string: urlString)
        let session = URLSession.shared

        session.dataTask(with: url!) {(data, response, error) in

            guard error == nil else { return }
            guard let data = data else { return }

            do {

                let json = try JSON(data: data)
                let items = json["items"]

                for arr in items.arrayValue {

                    self.aRepos.append(RepoData(json: arr))
                }


                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }

            } catch let error {
                print(error.localizedDescription)
            }
            }.resume()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ItemListCell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemListCell
        let index = indexPath.row
        let item = self.aRepos[index]
        
        cell.lblNameRepo.text = item.name
        cell.lblOwnerRepo.text = "by " + item.login!
        cell.lblCount.text = item.stargazers_count
        
        let urlImage = URL(string: item.avatar_url!)
        let imageData = try! Data(contentsOf: urlImage!)
        
        cell.imageView?.image = UIImage(data: imageData)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    @objc func refresh(sender:AnyObject) {
        
        
        self.tableview.reloadData()
        self.refreshControl.endRefreshing()
    }
}

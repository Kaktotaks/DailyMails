//
//  ViewController.swift
//  DailyMail
//
//  Created by Леонід Шевченко on 28.09.2021.
//

import UIKit
import Alamofire
import RealmSwift

class MediaViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mediaSegmentedControl: UISegmentedControl!
    
    var mostVieweds: [Viewed] = []
    var viewedMediaMetadatas: [ViewedMediaMetadata] = []
    var mostEmaileds: [Emailed] = []
    var mostShareds: [Shared] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "DailyMail"
        
        self.tableView.register(UINib(nibName: "MostViewedTableViewCell", bundle: nil), forCellReuseIdentifier: "MostViewedTableViewCell")
        
        self.tableView.register(UINib(nibName: "MostEmailedTableViewCell", bundle: nil), forCellReuseIdentifier: "MostEmailedTableViewCell")
        
        self.tableView.register(UINib(nibName: "MostSharedTableViewCell", bundle: nil), forCellReuseIdentifier: "MostSharedTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.requestMostViewed()
        self.requestMostEmailed()
        self.requestMostShared()
        
    }
    
    func requestMostViewed() {
        let url = "https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json?api-key=vuIfURUfUeJfm6S5iYK17hxXNBPBOQEz"
        AF.request(url).responseJSON { responce in
            
            let decoder = JSONDecoder()
            
            if let data = try? decoder.decode(ViewedResult.self, from: responce.data!){
                self.mostVieweds = data.vieweds ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    func requestMostEmailed() {
        let url = "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json?api-key=vuIfURUfUeJfm6S5iYK17hxXNBPBOQEz"
        AF.request(url).responseJSON { responce in
            
            let decoder = JSONDecoder()
            
            if let data = try? decoder.decode(EmailedResult.self, from: responce.data!){
                self.mostEmaileds = data.emaileds ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    func requestMostShared() {
        let url = "https://api.nytimes.com/svc/mostpopular/v2/shared/30/facebook.json?api-key=vuIfURUfUeJfm6S5iYK17hxXNBPBOQEz"
        AF.request(url).responseJSON { responce in
            
            let decoder = JSONDecoder()
            
            if let data = try? decoder.decode(SharedResult.self, from: responce.data!){
                self.mostShareds = data.shareds ?? []
                self.tableView.reloadData()
            }
        }
    }
}

extension MediaViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let selectedIndex = self.mediaSegmentedControl.selectedSegmentIndex
        
        switch selectedIndex
        {
        case 0:
            return self.mostVieweds.count
        case 1:
            return self.mostEmaileds.count
        case 2:
            return self.mostShareds.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedIndex = self.mediaSegmentedControl.selectedSegmentIndex
        switch selectedIndex {
            
        case 0:
            guard let mostViewedCell = tableView.dequeueReusableCell(withIdentifier: "MostViewedTableViewCell", for: indexPath) as? MostViewedTableViewCell else {
                return UITableViewCell()
            }
            let mostViewedMedia = self.mostVieweds[indexPath.row]
//!            let mostViewedPathString = self.viewedMediaMetadatas[indexPath.row].url?.first - хочу подтянуть картинку() по  проперти url : String?, но не выходит 
            mostViewedCell.mostViewedConfigureWith(imageURL: URL(string: ""),
                                                   mostViewedName: mostViewedMedia.title,
                                                   publishedDateText: mostViewedMedia.published_date,
                                                   authorName: mostViewedMedia.byline)
            return mostViewedCell
            
        case 1:
            guard let mostEmailedCell = tableView.dequeueReusableCell(withIdentifier: "MostEmailedTableViewCell", for: indexPath) as? MostEmailedTableViewCell else {
                return UITableViewCell()
            }
            let mostEmailedMedia = self.mostEmaileds[indexPath.row]
//!            let mostEmailedPathString = self.mostEmaileds[indexPath.row].url ?? ""
            mostEmailedCell.mostEmailedConfigureWith(imageURL: URL(string: ""), mostEmailedName: mostEmailedMedia.title, publishedDateText: mostEmailedMedia.published_date)
            return mostEmailedCell
            
        case 2:
            guard let mostSharedCell = tableView.dequeueReusableCell(withIdentifier: "MostSharedTableViewCell", for: indexPath) as? MostSharedTableViewCell else {
                return UITableViewCell()
            }
            let mostSharedMedia = self.mostShareds[indexPath.row]
//!            let mostSharedPathString = self.mostShareds[indexPath.row].url ?? ""
            mostSharedCell.mostSharedConfigureWith(imageURL: URL(string: ""), mostSharedName: mostSharedMedia.title, publishedDateText: mostSharedMedia.published_date)
            return mostSharedCell
            
        default:
            return UITableViewCell()
        }
    }
    
    @IBAction func mediaSegmentedChanged(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
}

// MARK: - Save !
// MARK: - Save !
// MARK: - Save !

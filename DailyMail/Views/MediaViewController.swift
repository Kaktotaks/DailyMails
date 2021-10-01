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
//    var viewedMediaMetadatas: [ViewedMediaMetadata] = []
    var mostEmaileds: [Emailed] = []
    var mostShareds: [Shared] = []
    
    let realm = try? Realm()
    
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

//MARK: - DataSource for tableView
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
//            let mostViewedPathString = self.viewedMediaMetadatas.first?.url
            mostViewedCell.configureWith(imageURL: URL(string: "https://s3-symbol-logo.tradingview.com/new-york-times--600.png"),
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
            mostEmailedCell.configureWith(imageURL: URL(string: "https://s3-symbol-logo.tradingview.com/new-york-times--600.png"),
                                                     mostEmailedName: mostEmailedMedia.title,
                                                     publishedDateText: mostEmailedMedia.published_date,
                                                     authorName: mostEmailedMedia.byline)
            return mostEmailedCell
            
        case 2:
            guard let mostSharedCell = tableView.dequeueReusableCell(withIdentifier: "MostSharedTableViewCell", for: indexPath) as? MostSharedTableViewCell else {
                return UITableViewCell()
            }
            let mostSharedMedia = self.mostShareds[indexPath.row]
//!            let mostSharedPathString = self.mostShareds[indexPath.row].url ?? ""
            mostSharedCell.configureWith(imageURL: URL(string: "https://s3-symbol-logo.tradingview.com/new-york-times--600.png"),
                                                   mostSharedName: mostSharedMedia.title,
                                                   publishedDateText: mostSharedMedia.published_date,
                                                   authorName: mostSharedMedia.byline)
            return mostSharedCell
            
        default:
            return UITableViewCell()
        }
    }
    
    @IBAction func mediaSegmentedChanged(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
}

//MARK: - Delegate for tableView
extension MediaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let selectedIndex = self.mediaSegmentedControl.selectedSegmentIndex
        
        switch selectedIndex {
        case 0:
            let viewedIdentifier = String(describing: MostViewedDetailsViewController.self)
            
            if let detailViewController = storyboard.instantiateViewController(identifier: viewedIdentifier) as? MostViewedDetailsViewController {
                detailViewController.mostViewed = self.mostVieweds[indexPath.row]
                
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
        case 1:
            let emailedIdentifier = String(describing: MostEmailedDetailsViewController.self)
            
            if let detailViewController = storyboard.instantiateViewController(identifier: emailedIdentifier) as? MostEmailedDetailsViewController {
                detailViewController.mostEmailed = self.mostEmaileds[indexPath.row]
                
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
            
        case 2:
            let sharedIdentifier = String(describing: MostSharedDetailsViewController.self)
            
            if let detailViewController = storyboard.instantiateViewController(identifier: sharedIdentifier) as? MostSharedDetailsViewController {
                detailViewController.mostShared = self.mostShareds[indexPath.row]
                
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
            
        default:
            break
    
        }
        
    }
    
    //MARK:- Appearing cells animation
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
                let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -100, 0)
                cell.layer.transform = rotationTransform
                cell.alpha = 0.5
        
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
}

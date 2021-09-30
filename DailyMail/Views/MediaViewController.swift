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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "DailyMail"
        
        self.tableView.register(UINib(nibName: "MostViewedTableViewCell", bundle: nil), forCellReuseIdentifier: "MostViewedTableViewCell")
        
        self.tableView.register(UINib(nibName: "MostEmailedTableViewCell", bundle: nil), forCellReuseIdentifier: "MostEmailedTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.requestMostViewed()
        self.requestMostEmailed()
        
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
//            let mostViewedPathString = self.mostVieweds[indexPath.row].url ?? ""
            mostViewedCell.mostViewedConfigureWith(imageURL: URL(string: ""), mostViewedName: mostViewedMedia.title, publishedDateText: mostViewedMedia.published_date)
            return mostViewedCell
            
        case 1:
            guard let mostEmailedCell = tableView.dequeueReusableCell(withIdentifier: "MostEmailedTableViewCell", for: indexPath) as? MostEmailedTableViewCell else {
                return UITableViewCell()
            }
            let mostEmailedMedia = self.mostEmaileds[indexPath.row]
//            let mostEmailedPathString = self.mostEmaileds[indexPath.row].url ?? ""
            mostEmailedCell.mostEmailedConfigureWith(imageURL: URL(string: ""), mostEmailedName: mostEmailedMedia.title, publishedDateText: mostEmailedMedia.published_date)
            return mostEmailedCell
            
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

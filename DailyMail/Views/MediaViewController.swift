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
    
    var mostVieweds: [Viewed] = []
    var viewedMediaMetadatas: [ViewedMediaMetadata] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "DailyMail"
        
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MostViewedTableViewCell")
        self.tableView.register(UINib(nibName: "MostViewedTableViewCell", bundle: nil), forCellReuseIdentifier: "MostViewedTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.requestMostViewed()
        
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
}

extension MediaViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mostVieweds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let mostViewedCell = tableView.dequeueReusableCell(withIdentifier: "MostViewedTableViewCell", for: indexPath) as? MostViewedTableViewCell else {
            return UITableViewCell()
        }
        let mostViewedMedia = self.mostVieweds[indexPath.row]
        let mostViewedPathString = self.mostVieweds[indexPath.row].url ?? ""
        mostViewedCell.mostViewedConfigureWith(imageURL: URL(string: mostViewedPathString), mostViewedName: mostViewedMedia.title, publishedDateText: mostViewedMedia.published_date)
        return mostViewedCell
    }
    
}

// MARK: - Save !
// MARK: - Save !
// MARK: - Save !

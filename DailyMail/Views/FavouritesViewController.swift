//
//  FavouritesViewController.swift
//  DailyMail
//
//  Created by Леонід Шевченко on 01.10.2021.
//

import UIKit
import RealmSwift
import Alamofire


class FavouritesViewController: UIViewController {
    
    // MARK: DB properties
    var mostVieweds: [Viewed] = []
    var mostEmaileds: [Emailed] = []
    var mostShareds: [Shared] = []
    
    let realm = try? Realm()
    
    @IBOutlet weak var mediaSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favourites"
        
        self.tableView.register(UINib(nibName: "MostViewedTableViewCell", bundle: nil), forCellReuseIdentifier: "MostViewedTableViewCell")
        
        self.tableView.register(UINib(nibName: "MostEmailedTableViewCell", bundle: nil), forCellReuseIdentifier: "MostEmailedTableViewCell")
        
        self.tableView.register(UINib(nibName: "MostSharedTableViewCell", bundle: nil), forCellReuseIdentifier: "MostSharedTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            self.mostVieweds = self.getMostVieweds()
            self.mostEmaileds = self.getMostEmaileds()
            self.mostShareds = self.getMostShareds()
            self.tableView.reloadData()
    }
    
    //MARK: Privat
        private func getMostVieweds() -> [Viewed] {
            
            var mostVieweds: [Viewed] = []
            guard let mostViewedsResults = realm?.objects(MediaRealm.self) else { return [] }
            for view in mostViewedsResults {
                let codableVieweds = Viewed(from: view)
                mostVieweds.append(codableVieweds)
            }
            
            return mostVieweds
        }
   
    
    //MARK: Privat
        private func getMostEmaileds() -> [Emailed] {
            
            var mostEmaileds: [Emailed] = []
            guard let mostEmailedsResults = realm?.objects(MediaRealm.self) else { return [] }
            for email in mostEmailedsResults {
                let codableEmaileds = Emailed(from: email)
                mostEmaileds.append(codableEmaileds)
            }
            
            return mostEmaileds
        }
    
    //MARK: Privat
        private func getMostShareds() -> [Shared] {
            
            var mostShareds: [Shared] = []
            guard let mostSharedsResults = realm?.objects(MediaRealm.self) else { return [] }
            for shared in mostSharedsResults {
                let codableShareds = Shared(from: shared)
                mostShareds.append(codableShareds)
            }
            
            return mostShareds
        }
    
    
}


extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedIndex = self.mediaSegmentedControl.selectedSegmentIndex
        
        
        switch selectedIndex {
        case 0:
            
            let mostViewedCell = tableView.dequeueReusableCell(withIdentifier: "MostViewedTableViewCell", for: indexPath) as! MostViewedTableViewCell
            
            // UI for mostViewedCell
            let viewedMedia = self.mostVieweds[indexPath.row]
            mostViewedCell.configureWith(imageURL: URL(string: "https://s3-symbol-logo.tradingview.com/new-york-times--600.png"),
                                         mostViewedName: viewedMedia.title,
                                         publishedDateText: viewedMedia.published_date,
                                         authorName: viewedMedia.byline)
            
            return mostViewedCell
            
        case 1:
            
            let mostEmailedCell = tableView.dequeueReusableCell(withIdentifier: "MostEmailedTableViewCell", for: indexPath) as! MostEmailedTableViewCell
            
            // UI for mostEmailedCell
            let emailedMedia = self.mostEmaileds[indexPath.row]
            mostEmailedCell.configureWith(imageURL: URL(string: "https://s3-symbol-logo.tradingview.com/new-york-times--600.png"),
                                         mostEmailedName: emailedMedia.title,
                                         publishedDateText: emailedMedia.published_date,
                                         authorName: emailedMedia.byline)
            
            return mostEmailedCell
            
        case 2:
            
            let mostSharedCell = tableView.dequeueReusableCell(withIdentifier: "MostSharedTableViewCell", for: indexPath) as! MostSharedTableViewCell
            
            // UI for mostSharedCell
            let sharedMedia = self.mostShareds[indexPath.row]
            mostSharedCell.configureWith(imageURL: URL(string: "https://s3-symbol-logo.tradingview.com/new-york-times--600.png"),
                                         mostSharedName: sharedMedia.title,
                                         publishedDateText: sharedMedia.published_date,
                                         authorName: sharedMedia.byline)
            
            return mostSharedCell
            
            
        default:
            return UITableViewCell()
        }
    }
    
    
    @IBAction func mediaSegmentedControlChanged(_ sender: Any) {
        self.tableView.reloadData()
    }
    
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
    
}

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
//            self.mostEmaileds = self.getMostEmaileds()
//            self.mostShareds = self.getMostShareds()
            self.tableView.reloadData()
    }
    
    //MARK: Privat
        private func getMostVieweds() -> [Viewed] {
            
            var mostVieweds: [Viewed] = []
            guard let mostViewedsResults = realm?.objects(MostViewedsRealm.self) else { return [] }
            for view in mostViewedsResults {
                let codableVieweds = Viewed(from: view)
                mostVieweds.append(codableVieweds)
            }
            
            return mostVieweds
        }
    //MARK: Privat
//        private func getMovies() -> [Movie] {
//
//            var movies = [Movie]()
//            guard let moviesResults = realm?.objects(MoviesRealm.self) else { return [] }
//            for movie in moviesResults {
//                let codableMovie = Movie(from: movie)
//                movies.append(codableMovie)
//            }
//            return movies
//        }
    
    
}


extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedIndex = self.mediaSegmentedControl.selectedSegmentIndex
        
        
        switch selectedIndex {
        case 0:
            
            let mostViewedCell = tableView.dequeueReusableCell(withIdentifier: "MostViewedTableViewCell", for: indexPath) as! MostViewedTableViewCell
            
            // UI for TVShows
            let viewedMedia = self.mostVieweds[indexPath.row]
            mostViewedCell.configureWith(imageURL: URL(string: "https://s3-symbol-logo.tradingview.com/new-york-times--600.png"),
                                         mostViewedName: viewedMedia.title,
                                         publishedDateText: viewedMedia.published_date,
                                         authorName: viewedMedia.byline)
            
            return mostViewedCell
            
        case 1:
            
            let mostViewedCell = tableView.dequeueReusableCell(withIdentifier: "MostViewedTableViewCell", for: indexPath) as! MostViewedTableViewCell
            
            return mostViewedCell
            
        case 2:
            
            let mostViewedCell = tableView.dequeueReusableCell(withIdentifier: "MostViewedTableViewCell", for: indexPath) as! MostViewedTableViewCell
            
            return mostViewedCell
            
            
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
            return self.mostVieweds.count
        case 2:
            return self.mostVieweds.count
        default:
            return 0
        }
    }
    
}

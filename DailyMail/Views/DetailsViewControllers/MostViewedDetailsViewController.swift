//
//  MostViewedDetailsViewController.swift
//  DailyMail
//
//  Created by Леонід Шевченко on 30.09.2021.
//

import UIKit
import SDWebImage
import RealmSwift
import Alamofire
import SafariServices

class MostViewedDetailsViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    let realm = try? Realm()
    var mostViewed: Viewed? = nil
    var mostViewedMedia: ViewedMediaMetadata? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.abstractLabel.layer.cornerRadius = 18
        
        self.abstractLabel.text = self.mostViewed?.abstract
        self.updatedLabel.text = self.mostViewed?.updated
        self.bylineLabel.text = self.mostViewed?.byline
        self.publisherLabel.text = self.mostViewed?.source
        self.titleLabel.text = self.mostViewed?.title
    
        if let posterPath = self.mostViewedMedia?.url {

            // Created a full link to the image
            let urlString = posterPath

            // And using the SDWebImage library, we set posterImageView an image, loaded by url
            self.posterImageView.sd_setImage(with: URL(string: urlString), completed: nil)

        }

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = mostViewed?.section
        
        let logoutBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addToFavouritesButtonPressed))

        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
    }
    
    @IBAction func addToFavouritesButtonPressed(_ sender: Any) {
        let mostViewedsRealm = MediaRealm()
        
        mostViewedsRealm.byline = self.mostViewed?.byline ?? ""
        mostViewedsRealm.updated = self.mostViewed?.updated ?? ""
        mostViewedsRealm.abstract = self.mostViewed?.abstract ?? ""
        mostViewedsRealm.source = self.mostViewed?.source ?? ""
        mostViewedsRealm.title = self.mostViewed?.title ?? ""
        mostViewedsRealm.published_date = self.mostViewed?.published_date ?? ""
        // Не добавлено только фото

        try? realm?.write {
            realm?.add(mostViewedsRealm)
        }
        self.showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Post saved in Favourites", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok 👌🏽", style: .cancel, handler: { action in
            print("Tapped Ok 👌🏽")
        }))
        
        present(alert, animated: true)
    }
    
    
    @IBAction func goToWebButtonPressed(_ sender: Any) {
        if let placesURLString = self.mostViewed?.url {
            if let placesURL = URL(string: placesURLString){
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                
                let web = SFSafariViewController(url: placesURL, configuration: config)
                present(web, animated: true)
            }
        }
    }
    
}

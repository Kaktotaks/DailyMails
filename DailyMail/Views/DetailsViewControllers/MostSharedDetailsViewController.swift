//
//  MostSharedDetailsViewController.swift
//  DailyMail
//
//  Created by Леонід Шевченко on 01.10.2021.
//

import UIKit
import SDWebImage
import RealmSwift
import Alamofire
import SafariServices

class MostSharedDetailsViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    let realm = try? Realm()
    var mostShared: Shared? = nil
    var mostSharedMedia: SharedMediaMetadata? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.abstractLabel.layer.cornerRadius = 18
        
        self.abstractLabel.text = self.mostShared?.abstract
        self.updatedLabel.text = self.mostShared?.updated
        self.bylineLabel.text = self.mostShared?.byline
        self.publisherLabel.text = self.mostShared?.source
        self.titleLabel.text = self.mostShared?.title
    
        if let posterPath = self.mostSharedMedia?.url {

            // Created a full link to the image
            let urlString = posterPath

            // And using the SDWebImage library, we set posterImageView an image, loaded by url
            self.posterImageView.sd_setImage(with: URL(string: urlString), completed: nil)

        }

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = mostShared?.section
        
        let logoutBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addToFavouritesButtonPressed))

        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
    }
    
    @IBAction func addToFavouritesButtonPressed(_ sender: Any) {
        let mostSharedsRealm = MediaRealm()
        
        mostSharedsRealm.byline = self.mostShared?.byline ?? ""
        mostSharedsRealm.updated = self.mostShared?.updated ?? ""
        mostSharedsRealm.abstract = self.mostShared?.abstract ?? ""
        mostSharedsRealm.source = self.mostShared?.source ?? ""
        mostSharedsRealm.title = self.mostShared?.title ?? ""
        mostSharedsRealm.published_date = self.mostShared?.published_date ?? ""
        // Не добавлено только фото

        try? realm?.write {
            realm?.add(mostSharedsRealm)
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
        if let placesURLString = self.mostShared?.url {
            if let placesURL = URL(string: placesURLString){
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                
                let web = SFSafariViewController(url: placesURL, configuration: config)
                present(web, animated: true)
            }
        }
    }
    
}


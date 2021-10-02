//
//  MostEmailedDetailsViewController.swift
//  DailyMail
//
//  Created by Леонід Шевченко on 01.10.2021.
//

import UIKit
import SDWebImage
import RealmSwift
import Alamofire
import SafariServices

class MostEmailedDetailsViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    let realm = try? Realm()
    var mostEmailed: Emailed? = nil
    var mostEmailedMedia: EmailedMediaMetadata? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.abstractLabel.layer.cornerRadius = 18
        
        self.abstractLabel.text = self.mostEmailed?.abstract
        self.updatedLabel.text = self.mostEmailed?.updated
        self.bylineLabel.text = self.mostEmailed?.byline
        self.publisherLabel.text = self.mostEmailed?.source
        self.titleLabel.text = self.mostEmailed?.title
        self.posterImageView.sd_setImage(with: URL(string: Constants.Network.baseURL), completed: nil)

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = mostEmailed?.section
        
        let logoutBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addToFavouritesButtonPressed))

        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
    }
    
    @IBAction func addToFavouritesButtonPressed(_ sender: Any) {
        let mostEmailedsRealm = EmailedRealm()
        
        mostEmailedsRealm.byline = self.mostEmailed?.byline ?? ""
        mostEmailedsRealm.updated = self.mostEmailed?.updated ?? ""
        mostEmailedsRealm.abstract = self.mostEmailed?.abstract ?? ""
        mostEmailedsRealm.source = self.mostEmailed?.source ?? ""
        mostEmailedsRealm.title = self.mostEmailed?.title ?? ""
        mostEmailedsRealm.published_date = self.mostEmailed?.published_date ?? ""
        // Не добавлено только фото

        try? realm?.write {
            realm?.add(mostEmailedsRealm)
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
        if let placesURLString = self.mostEmailed?.url {
            if let placesURL = URL(string: placesURLString){
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                
                let web = SFSafariViewController(url: placesURL, configuration: config)
                present(web, animated: true)
            }
        }
    }
    
}

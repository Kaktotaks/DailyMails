//
//  MostViewedDetailsViewController.swift
//  DailyMail
//
//  Created by Леонід Шевченко on 30.09.2021.
//

import UIKit
import SDWebImage
//import RealmSwift
import Alamofire
import SafariServices

class MostViewedDetailsViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    
    
    
    var mostViewed: Viewed? = nil
    var mostViewedMedia: ViewedMediaMetadata? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.abstractLabel.layer.cornerRadius = 18
        
        self.abstractLabel.text = self.mostViewed?.abstract
        self.updatedLabel.text = self.mostViewed?.updated
        self.bylineLabel.text = self.mostViewed?.byline
        self.publisherLabel.text = self.mostViewed?.source
    
        if let posterPath = self.mostViewedMedia?.url {

            // Created a full link to the image
            let urlString = posterPath

            // And using the SDWebImage library, we set posterImageView an image, loaded by url
            self.posterImageView.sd_setImage(with: URL(string: urlString), completed: nil)

        }

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = mostViewed?.title
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

//
//  MostEmailedDetailsViewController.swift
//  DailyMail
//
//  Created by Леонід Шевченко on 01.10.2021.
//

import UIKit
import SDWebImage
//import RealmSwift
import Alamofire
import SafariServices


class MostEmailedDetailsViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
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
    
        if let posterPath = self.mostEmailedMedia?.url {

            // Created a full link to the image
            let urlString = posterPath

            // And using the SDWebImage library, we set posterImageView an image, loaded by url
            self.posterImageView.sd_setImage(with: URL(string: urlString), completed: nil)

        }

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = mostEmailed?.section
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

//
//  MostViewedTableViewCell.swift
//  DailyMail
//
//  Created by Леонід Шевченко on 28.09.2021.
//

import UIKit
import SDWebImage

class MostViewedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var smallPosterImageView: UIImageView!
    @IBOutlet weak var mostViewedTitleLabel: UILabel!
    @IBOutlet weak var mostViewedPublishedDateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.layer.cornerRadius = 24
        self.smallPosterImageView.layer.cornerRadius = 18
    }

    func mostViewedConfigureWith(imageURL: URL?, mostViewedName: String?, publishedDateText: String?, authorName: String? ) {
        self.mostViewedTitleLabel.text = mostViewedName
        self.mostViewedPublishedDateLabel.text = publishedDateText
        self.smallPosterImageView.sd_setImage(with: imageURL, completed: nil)
        self.authorLabel.text = authorName
    }
}

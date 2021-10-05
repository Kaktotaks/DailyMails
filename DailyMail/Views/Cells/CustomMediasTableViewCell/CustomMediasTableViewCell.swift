//
//  MostViewedTableViewCell.swift
//  DailyMail
//
//  Created by Леонід Шевченко on 28.09.2021.
//

import UIKit
import SDWebImage

class CustomMediasTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var smallPosterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.layer.cornerRadius = 24
        self.smallPosterImageView.layer.cornerRadius = 18
    }

    func configureWith(imageURL: URL?, titleName: String?, publishedDateText: String?, authorName: String? ) {
        self.titleLabel.text = titleName
        self.publishedDateLabel.text = publishedDateText
        self.smallPosterImageView.sd_setImage(with: imageURL, completed: nil)
        self.authorLabel.text = authorName
    }
    
}

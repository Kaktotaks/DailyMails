//
//  MostEmailedTableViewCell.swift
//  DailyMail
//
//  Created by Леонід Шевченко on 30.09.2021.
//

import UIKit

class MostEmailedTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var smallPosterImageView: UIImageView!
    @IBOutlet weak var mostEmailedTitleLabel: UILabel!
    @IBOutlet weak var mostEmailedPublishedDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.layer.cornerRadius = 18
        self.smallPosterImageView.layer.cornerRadius = 18
    }
    
    func mostEmailedConfigureWith(imageURL: URL?, mostEmailedName: String?, publishedDateText: String?) {
        self.mostEmailedTitleLabel.text = mostEmailedName
        self.mostEmailedPublishedDateLabel.text = publishedDateText
        self.smallPosterImageView.sd_setImage(with: imageURL, completed: nil)
    }
    
}

//
//  MostSharedTableViewCell.swift
//  DailyMail
//
//  Created by Леонід Шевченко on 30.09.2021.
//

import UIKit

class MostSharedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var smallPosterImageView: UIImageView!
    @IBOutlet weak var mostSharedTitleLabel: UILabel!
    @IBOutlet weak var mostSharedPublishedDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.layer.cornerRadius = 24
        self.smallPosterImageView.layer.cornerRadius = 18
    }
    
    func mostSharedConfigureWith(imageURL: URL?, mostSharedName: String?, publishedDateText: String?) {
        self.mostSharedTitleLabel.text = mostSharedName
        self.mostSharedPublishedDateLabel.text = publishedDateText
        self.smallPosterImageView.sd_setImage(with: imageURL, completed: nil)
    }
    
}

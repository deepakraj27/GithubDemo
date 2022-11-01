//
//  PRCellViewLayout.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 01/11/22.
//

import UIKit
import SDWebImage

class PRCellViewLayout: UITableViewCell {
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var closedAtLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.authorImageView.sd_cancelCurrentImageLoad()
        self.authorImageView.image = nil
    }

    func setupCell(uiModel: PRUIViewModel?) {
        if let uiModel = uiModel {
            if let authorImageURL = uiModel.componentAuthorImageURL {
                self.authorImageView.sd_setImage(with: authorImageURL as URL, placeholderImage: UIImage(named: "person-placeholder"))
            }
            
            self.titleLabel.attributedText = uiModel.componentTitle
            self.authorNameLabel.attributedText = uiModel.componentAuthorName

            self.createdAtLabel.attributedText = uiModel.componentCreatedAt
            self.closedAtLabel.attributedText = uiModel.componentClosedAt
        }
    }
}

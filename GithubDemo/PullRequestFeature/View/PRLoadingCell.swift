//
//  PRLoadingCell.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 02/11/22.
//

import UIKit

class PRLoadingCell: UITableViewCell {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func startAnimating() {
        self.activityIndicator.startAnimating()
    }

    func stopAnimating() {
        self.activityIndicator.stopAnimating()
    }
}

//
//  PRUIViewModel.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 01/11/22.
//

import Foundation
import UIKit

extension PRUIViewModel{
    private struct PRUIViewModelConstants{
        static let titleFont: UIFont = UIFont.setupFont(16.0)
        static let subtitleFont: UIFont = UIFont.setupFont(14.0, true)

        static let defaultTextColor : UIColor = .black
    }
}

final class PRUIViewModel {
    //MARK:- Properties of VM
    var componentTitle: NSAttributedString? = nil
    var componentAuthorName: NSAttributedString? = nil
    var componentCreatedAt: NSAttributedString? = nil
    var componentClosedAt: NSAttributedString? = nil
    var componentAuthorImageURL: NSURL? = nil

    init(_ pullRequest: PullRequest?) {
        if let pullRequest = pullRequest{
            if let title = pullRequest.title,!title.isEmpty {
                self.componentTitle =
                Helper.getAttributedText(text: title, color: PRUIViewModelConstants.defaultTextColor, alignment: .left, font: PRUIViewModelConstants.titleFont)
            }

            if let authorName = pullRequest.user?.name,!authorName.isEmpty {
                self.componentAuthorName =
                Helper.getAttributedText(text: authorName, color: PRUIViewModelConstants.defaultTextColor, alignment: .left, font: PRUIViewModelConstants.subtitleFont)
            }

            if let createdAt = pullRequest.createdAt, !createdAt.isEmpty, let date = Helper.getDateInReadableFormat(createdAt) {
                self.componentCreatedAt = Helper.getMultiAttributedText("PR Created - ", date)
            }


            if let closedAt = pullRequest.closedAt, !closedAt.isEmpty, let date = Helper.getDateInReadableFormat(closedAt) {
                self.componentClosedAt = Helper.getMultiAttributedText("PR Closed - ", date)
            }

            if let urlString = pullRequest.user?.avatarURL, !urlString.isEmpty {
                self.componentAuthorImageURL = NSURL(string: urlString)
            }
        }
    }
}


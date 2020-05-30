//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
class TopicCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var postersLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        userImage.layer.cornerRadius = 32
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        commentsLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        postersLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        commentsLabel.textColor = UIColor.black
        postersLabel.textColor = UIColor.black
        dateLabel.textColor = UIColor.black
    }
    
//    var userViewModels: UserCellViewModel? {
//        didSet {
//            guard let userViewModels = userViewModels else { return }
//            print("\(userViewModels.user.avatarTemplate)")
//        }
//    }
    
    var viewModel: TopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.textLabelText
            commentsLabel.text = "\(viewModel.topic.postsCount)"
            postersLabel.text = "\(viewModel.topic.posters.count)"
            let inputStringDate = "\(viewModel.topic.createdAt)"
            let inputFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "es_ES")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600)
            dateFormatter.dateFormat = inputFormat
            guard let date = dateFormatter.date(from: inputStringDate) else { return }
            let outputFormat = "MMM d"
            dateFormatter.dateFormat = outputFormat
            let outputStringDate = dateFormatter.string(from: date)
            dateLabel.text = outputStringDate
        }
    }
}

extension TopicCell: TopicCellViewModelViewDelegate {
    func userImageFetched() {
        userImage?.image = viewModel?.lastPosterImage
        setNeedsLayout()
    }
}

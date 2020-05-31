//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 28/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            userName?.text = viewModel.textLabelText
            userName?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            userImage?.image = viewModel.userImage
            userImage.layer.masksToBounds = true
            userImage.layer.cornerRadius = 40
        }
    }
}

extension UserCell: UserCellViewModelViewDelegate {
    func userImageFetched() {
        userImage?.image = viewModel?.userImage
        userImage.transform = userImage.transform.scaledBy(x: 2, y: 2)
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.curveEaseInOut], animations: {  [weak self] in
            guard let self = self else { return }
            var number = 0
            repeat {
                self.userImage.transform = self.userImage.transform.rotated(by: .pi)
                number += 1
            } while number < 20
            self.userImage.alpha = 1.0
            self.userImage.transform = self.userImage.transform.scaledBy(x: 0.5, y: 0.5)
        })
    }
}

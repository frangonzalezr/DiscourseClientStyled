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
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.curveEaseInOut], animations: {  [weak self] in
            guard let self = self else { return }
            self.userImage.alpha = 1.0
        })
    }
}

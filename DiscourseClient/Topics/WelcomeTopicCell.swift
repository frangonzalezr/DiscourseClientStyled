//
//  WelcomeTopicCell.swift
//  DiscourseClient
//
//  Created by Fran González on 24/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class WelcomeTopicCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var cuadroNaranja: UIView!
    
    var viewModel: TopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.textLabelText
            subTitleLabel.text = viewModel.subTitletextLabelText
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        subTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        cuadroNaranja.layer.cornerRadius = 8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

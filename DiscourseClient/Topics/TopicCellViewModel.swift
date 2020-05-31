//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit


protocol TopicCellViewModelViewDelegate: class {
    func posterImageFetched()
}

class TopicCellViewModel {
    weak var viewDelegate: TopicCellViewModelViewDelegate?
    let topic: Topic
    var textLabelText: String?
    var subTitletextLabelText: String?
    var lastPosterImage: UIImage?
    
    init(topic: Topic) {
        self.topic = topic
        textLabelText = topic.title
        subTitletextLabelText = topic.slug
        var imageStringURL = "https://mdiscourse.keepcoding.io"
        imageStringURL.append(topic.lastPosterUsername.replacingOccurrences(of: "{size}", with: "100"))
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = URL(string: imageStringURL), let data = try? Data(contentsOf: url) {
                self?.lastPosterImage = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.viewDelegate?.posterImageFetched()
                }
            }
        }
    }
    
    
}

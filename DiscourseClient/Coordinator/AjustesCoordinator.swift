//
//  AjustesCoordinator.swift
//  DiscourseClient
//
//  Created by Fran González on 23/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Coordinator que representa el tab del categories list
class AjustesCoordinator: Coordinator {
    let presenter: UINavigationController
    let categoriesDataManager: CategoriesDataManager

    init(presenter: UINavigationController, categoriesDataManager: CategoriesDataManager) {
        self.categoriesDataManager = categoriesDataManager
        self.presenter = presenter
    }

    override func start() {
        let categoriesViewModel = CategoriesViewModel(categoriesDataManager: categoriesDataManager)
        let categoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)
        categoriesViewModel.viewDelegate = categoriesViewController
        categoriesViewController.title = NSLocalizedString("Ajustes", comment: "")
        presenter.pushViewController(categoriesViewController, animated: false)
    }
    
    override func finish() {}
}

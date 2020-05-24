//
//  TopicsViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa un listado de topics
class TopicsViewController: UIViewController {

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "TopicCell")
        table.register(UINib(nibName: "WelcomeTopicCell", bundle: nil), forCellReuseIdentifier: "WelcomeTopicCell")
        return table
    }()

    let viewModel: TopicsViewModel

    init(viewModel: TopicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let plusButton = UIButton(type: .custom)
        plusButton.setImage(UIImage(named: "icoNew"), for: .normal)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plusButton)
        NSLayoutConstraint.activate([
            plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16.0),
            plusButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0)
        ])
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)


        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icoAdd")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(plusButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icoSearch")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc func plusButtonTapped() {
        viewModel.plusButtonTapped()
    }
    
    @objc func searchButtonTapped() {
//        LO IMPLEMENTARE
//        viewModel.searchButtonTapped()
    }
    fileprivate func showErrorFetchingTopicsAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topics\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
}

extension TopicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "WelcomeTopicCell", for: indexPath) as? WelcomeTopicCell,
                let cellViewModel = viewModel.viewModel(at: indexPath) {
                cell.viewModel = cellViewModel
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicCell,
                let cellViewModel = viewModel.viewModel(at: indexPath) {
                cell.viewModel = cellViewModel
                return cell
            }
        }


        fatalError()
    }
}

extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 151
        } else {
            return 96
        }
    }
}

extension TopicsViewController: TopicsViewDelegate {
    func topicsFetched() {
        tableView.reloadData()
    }

    func errorFetchingTopics() {
        showErrorFetchingTopicsAlert()
    }
}

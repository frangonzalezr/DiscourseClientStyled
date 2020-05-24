//
//  UsersViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 28/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    let viewModel: UsersViewModel

    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white82
        collection.dataSource = self
        collection.delegate = self
        collection.register(UINib(nibName: "UserCell", bundle: nil), forCellWithReuseIdentifier: "UserCell")
        if let flowLayout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
        flowLayout.sectionInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        flowLayout.minimumInteritemSpacing = 20.5
        flowLayout.itemSize = CGSize(width: 94, height: 124)
        flowLayout.estimatedItemSize = .zero
        flowLayout.minimumLineSpacing = 18
        collection.setCollectionViewLayout(flowLayout, animated: true)
        }
        return collection
    }()


    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icoAdd")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(plusButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icoSearch")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func plusButtonTapped() {
        
        // LO IMPLEMENTARE
//        viewModel.plusButtonTapped()
    }
    
        @objc func searchButtonTapped() {
            // LO IMPLEMENTARE
    //        viewModel.searchButtonTapped()
        }


    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    fileprivate func showErrorFetchingUsers() {
        showAlert("Error fetching users\nPlease try again later")
    }
}




extension UsersViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath) as? UserCell,
                let cellViewModel = viewModel.viewModel(at: indexPath) {
                cell.viewModel = cellViewModel
                return cell
            }

            fatalError()
        }
    }
    

extension UsersViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension UsersViewController: UsersViewModelViewDelegate {
    func usersWereFetched() {
        collectionView.reloadData()
    }

    func errorFetchingUsers() {
        showErrorFetchingUsers()
    }
}

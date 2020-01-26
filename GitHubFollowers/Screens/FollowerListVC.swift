    //
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Laurent B on 01/01/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

    protocol FollowerListVCDelegate: class {
        func didRequestFollowers(for username: String)
    }
    
class FollowerListVC: UIViewController {

    
    
    enum Section {
        case main
    }
    
    var username: String!
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureViewController() {
                //title = username
                view.backgroundColor = .systemBackground
                navigationController?.navigationBar.prefersLargeTitles = true
    }

    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let avalaibleWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        
        let itemWidth = avalaibleWidth / 3
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    func getFollowers(username: String, page: Int) {
            showLoadingView()
            NetworkManager.shared.getFollowers(for: username, page: page) {[weak self] result in
                
                guard let self = self else { return }
                self.dismillLoadingView()
                switch result {
                    case .success(let followers):
                        if followers.count < 100 { self.hasMoreFollowers = false }
                        self.followers.append(contentsOf:  followers)
                        
                        if self.followers.isEmpty {
                            let message = "This user doesnt have any followers. go follow them 😀"
                            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                            return
                             }
                        self.updateData(on: self.followers)
                    case .failure(let error):
                        self.presentGFAlertOnMainThread(title: "Bad things happened", message: error.rawValue, buttonTitle: "OK")
                }
            }

    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: {(collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot,animatingDifferences: true) }
        
    }
    
}

    
extension FollowerListVC: UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
            
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
                page += 1
                getFollowers(username: username, page: page)
            }
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    }

    
extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
        func updateSearchResults(for searchController: UISearchController) {
            guard let filter = searchController.searchBar.text, !filter.isEmpty else {
                updateData(on: followers)
                return}
            isSearching = true
            
            filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased())}
            updateData(on: filteredFollowers)
        }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}

    extension FollowerListVC: FollowerListVCDelegate {
        
        func didRequestFollowers(for username: String) {
            self.username = username
            print("follower")
            title = username
            page = 1
            followers.removeAll()
            filteredFollowers.removeAll()
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            getFollowers(username: username, page: page)
            //collectionView.setContentOffset(.zero, animated: true)
        }
        

    }

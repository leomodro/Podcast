//
//  EpisodesController.swift
//  Podcast
//
//  Created by Leonardo Modro on 12/03/2018.
//  Copyright © 2018 Leonardo Modro. All rights reserved.
//

import UIKit
import FeedKit

class EpisodesController: UITableViewController {
    
    let favoritePodcastKey = "favoritePodcastKey"
    var podcast: Podcast! {
        didSet {
            navigationItem.title = podcast.trackName
            fetchEpisodes()
        }
    }
    private func fetchEpisodes() {
        guard let feedURL = podcast.feedUrl else { return }
        APIService.shared.fetchEpisodes(feedURL: feedURL) { (episodes) in
            self.episodes = episodes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    fileprivate let cellId = "cellId"
    var episodes = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBarButtons()
    }
    
    //MARK: - Setups
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    private func setupNavigationBarButtons() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(handleSaveFavorite)),
            UIBarButtonItem(title: "Fetch", style: .plain, target: self, action: #selector(handleFetchFavorite))
        ]
    }
    
    @objc private func handleSaveFavorite() {
        let data = NSKeyedArchiver.archivedData(withRootObject: self.podcast)
        UserDefaults.standard.set(data, forKey: favoritePodcastKey)
    }
    
    @objc private func handleFetchFavorite() {
        guard let data = UserDefaults.standard.data(forKey: favoritePodcastKey) else { return }
        let podcast = NSKeyedUnarchiver.unarchiveObject(with: data) as? Podcast
        print(podcast?.trackName)
    }
    
    //MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        let episode = episodes[indexPath.row]
        cell.episode = episode        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.episodes[indexPath.row]
        guard let mainTabBar = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
        mainTabBar.maximizePlayerDetails(episode: episode, playlistEpisodes: self.episodes)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return episodes.isEmpty ? 200 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
    
}

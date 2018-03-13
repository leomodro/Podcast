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
    
    var podcast: Podcast! {
        didSet {
            navigationItem.title = podcast.trackName
            fetchEpisodes()
        }
    }
    private func fetchEpisodes() {
        guard let feedURL = podcast.feedUrl else { return }
        let secureFeedURL = feedURL.contains("https") ? feedURL : feedURL.replacingOccurrences(of: "http", with: "https")
        guard let url = URL(string: secureFeedURL) else { return }
        let parser = FeedParser(URL: url)
        parser?.parseAsync(result: { (result) in
            switch result {
            case let .rss(feed):
                var episodes = [Episode]()
                feed.items?.forEach({ (feedItem) in
                    let episode = Episode(title: feedItem.title ?? "")
                    episodes.append(episode)
                })
                self.episodes = episodes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            case let .failure(error):
                print("Failed to parse feed: ", error)
                break
            default:
                print("Found a feed...")
            }
        })
    }
    fileprivate let cellId = "cellId"
    struct Episode {
        let title: String
    }
    var episodes = [
        Episode(title: "First Episode"),
        Episode(title: "Second Episode"),
        Episode(title: "Third Episode")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    //MARK: - Setups
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    //MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let episode = episodes[indexPath.row]
        cell.textLabel?.text = episode.title
        return cell
    }
    
}

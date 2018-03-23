//
//  UserDefaults.swift
//  Podcast
//
//  Created by Leonardo Modro on 23/03/2018.
//  Copyright © 2018 Leonardo Modro. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static let favoritePodcastKey = "favoritePodcastKey"
    static let downloadedEpisodesKey = "downloadedEpisodesKey"
    
    func savedPodcast() -> [Podcast] {
        guard let savedPodcastData = UserDefaults.standard.data(forKey: UserDefaults.favoritePodcastKey) else { return [] }
        guard let savedPodcast = NSKeyedUnarchiver.unarchiveObject(with: savedPodcastData) as? [Podcast] else { return [] }
        return savedPodcast
    }
    
    func deletePodcast(podcast: Podcast) {
        let podcasts = savedPodcast()
        let filteredPodcasts = podcasts.filter { (p) -> Bool in
            return p.trackName != podcast.trackName && p.artistName != podcast.artistName
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: filteredPodcasts)
        UserDefaults.standard.set(data, forKey: UserDefaults.favoritePodcastKey)
    }
    
    func downloadEpisode(episode: Episode) {
        do {
            var episodes = downloadedEpisodes()
            episodes.insert(episode, at: 0)
            let data = try JSONEncoder().encode(episodes)
            UserDefaults.standard.set(data, forKey: UserDefaults.downloadedEpisodesKey)
        } catch let err {
            print("Error encoding: ", err)
        }
    }
    
    func downloadedEpisodes() -> [Episode] {
        guard let episodesData = data(forKey: UserDefaults.downloadedEpisodesKey) else { return [] }
        do {
            let episodes = try JSONDecoder().decode([Episode].self, from: episodesData)
            return episodes
        } catch let err {
            print("Error decoding: ", err)
        }
        return []
    }
    
    func deleteEpisode(episode: Episode) {
        let savedEpisodes = downloadedEpisodes()
        let filteredEpisodes = savedEpisodes.filter { (e) -> Bool in
            // you should use episode.collectionId to be safer with deletes
            return e.title != episode.title
        }
        
        do {
            let data = try JSONEncoder().encode(filteredEpisodes)
            UserDefaults.standard.set(data, forKey: UserDefaults.downloadedEpisodesKey)
        } catch let encodeErr {
            print("Failed to encode episode:", encodeErr)
        }
    }
}

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
}

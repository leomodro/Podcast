//
//  Episode.swift
//  Podcast
//
//  Created by Leonardo Modro on 13/03/2018.
//  Copyright © 2018 Leonardo Modro. All rights reserved.
//

import Foundation
import FeedKit

struct Episode {
    let title: String
    let pubDate: Date
    let description: String
    let author: String
    var imageUrl: String?
    
    init(feedItem: RSSFeedItem) {
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.iTunes?.iTunesSubtitle ?? feedItem.description ?? ""
        self.author = feedItem.iTunes?.iTunesAuthor ?? ""
        self.imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href
    }
}

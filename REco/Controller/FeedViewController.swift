//
//  ViewController.swift
//  REco
//
//  Created by Dev Macbook on 11/20/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import UIKit

class FeedViewController: ViewController {
    
    var feedModel: FeedModel?
    var feedView: FeedView?
    
    func updateFeedView() {
        
        feedView!.updateFeed(posts: feedModel!.posts, articles: feedModel!.articles, events: feedModel!.events)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.feedModel = FeedModel(controller: self)
        self.feedView = FeedView(controller: self, view: self.view)
        
        updateFeedView()
        
    }


}


//
//  FeedModel.swift
//  REco
//
//  Created by Dev Macbook on 12/27/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import UIKit

struct FeedPost {
    
    var author: String
    var content: String
    var type: ActivityType
    var image: UIImage
    var time: String
    
}

struct NewsArticle {
    
    var name: String
    var imageURL: String
    var linkURL: String
    
}

struct Event {
    
    var name: String
    var imageURL: String
    var linkURL: String
    var date: String
    
}

class FeedModel: NSObject {

    var feedController: FeedViewController
    
    var posts: [FeedPost] = []
    var articles: [NewsArticle] = []
    var events: [Event] = []
    
    init(controller: FeedViewController) {
        
        feedController = controller
        
        super.init()
        
        TESTcreatePosts()
        TESTcreateNewsArticles()
        TESTcreateEvents()
        
    }
    
    func TESTcreatePosts() {
        
        posts = [   FeedPost(author: "Jason", content: "I recycled today, and have reduced my waste by 48% :-)", type: .Recycle, image: UIImage(named: "male")!, time: "7/17/17, 19:40"),
                    FeedPost(author: "Jill", content: "sweetgreen has compostable cutlery!", type: .Restaurant, image: UIImage(named: "female")!, time: "4/23/18, 22:38"),
                    FeedPost(author: "Jonathan", content: "Learned that the US has enough landfills to cover Indianna today", type: .Recycle, image: UIImage(named: "male2")!, time: "7/17/17, 19:40"),
                    FeedPost(author: "Joanna", content: "McDonalds should make their containers compostable", type: .Restaurant, image: UIImage(named: "female2")!, time: "2/2/18, 8:10"),
                    FeedPost(author: "Jack", content: "Did you compost today?", type: .Recycle, image: UIImage(named: "male3")!, time: "7/17/17, 19:40"),
                    FeedPost(author: "Jessica", content: "Have you ever eaten out of wooden bowls and plates? Feels so cool", type: .Restaurant, image: UIImage(named: "female3")!, time: "9/31/18, 11:31"),
                    FeedPost(author: "Joab", content: "Almost to silver tier!", type: .Recycle, image: UIImage(named: "male4")!, time: "7/8/18, 21:41"),
                    FeedPost(author: "Jacky", content: "The US deposits 7 tonnes of waste into the ocean...", type: .Restaurant, image: UIImage(named: "female4")!, time: "8/13/18, 12:40"),
                ]
        
    }
    
    func TESTcreateNewsArticles() {
        articles.append(NewsArticle(name: "Global warming will happen faster than we think", imageURL: "https://media.nature.com/w1172/magazine-assets/d41586-018-07586-5/d41586-018-07586-5_16303654.jpg", linkURL: "https://www.nature.com/articles/d41586-018-07586-5"))
        articles.append(NewsArticle(name: "Trash in America", imageURL: "https://frontiergroup.org/sites/default/files/styles/interior_page_report_image/public/trashcover.PNG?itok=g0hMoA8U", linkURL: "https://frontiergroup.org/reports/fg/trash-america"))
        articles.append(NewsArticle(name: "A Midterm Lay of the Land: Zero Waste in 2019", imageURL: "https://frontiergroup.org/sites/default/files/styles/large/public/trash.png?itok=ThlojOYt", linkURL: "https://frontiergroup.org/blogs/blog/fg/midterm-lay-land-zero-waste-2019"))
        articles.append(NewsArticle(name: "Global warming will happen faster than we think", imageURL: "https://media.nature.com/w1172/magazine-assets/d41586-018-07586-5/d41586-018-07586-5_16303654.jpg", linkURL: "https://www.nature.com/articles/d41586-018-07586-5"))
        articles.append(NewsArticle(name: "Trash in America", imageURL: "https://frontiergroup.org/sites/default/files/styles/interior_page_report_image/public/trashcover.PNG?itok=g0hMoA8U", linkURL: "https://frontiergroup.org/reports/fg/trash-america"))
        articles.append(NewsArticle(name: "A Midterm Lay of the Land: Zero Waste in 2019", imageURL: "https://frontiergroup.org/sites/default/files/styles/large/public/trash.png?itok=ThlojOYt", linkURL: "https://frontiergroup.org/blogs/blog/fg/midterm-lay-land-zero-waste-2019"))
        
    }
    
    func TESTcreateEvents() {
        events.append(Event(name: "Let's clean Brooklyn!", imageURL: "https://www.bluewaterbaltimore.org/wp-content/uploads/AOL_Carroll-Park3-930x698.jpg", linkURL: "https://www.nature.com/articles/d41586-018-07586-5", date: "Tue 21st Jan, 8:00PM"))
        events.append(Event(name: "Coney Island Beach Cleanup Project", imageURL: "https://residentialwastesystems.com/wp-content/uploads/2017/09/international-coastal-cleanup-day-768x512.jpg", linkURL: "https://frontiergroup.org/reports/fg/trash-america", date: "Tue 21st Jan, 10:00PM"))
        events.append(Event(name: "Separate your trash-Tuesdays", imageURL: "https://www.gazettenet.com/getattachment/1f5bb021-b527-49c8-87c9-60ae7a7ffe6c/ENV-WASTEREDUCTION-hg-021418-ph1", linkURL: "https://frontiergroup.org/blogs/blog/fg/midterm-lay-land-zero-waste-2019", date: "Wed 22nd Jan, 11:00AM"))
        events.append(Event(name: "Learn how to compost in your backyard", imageURL: "https://www.oregonmetro.gov/sites/default/files/styles/content/public/2014/05/16/compost_methods_food_scraps.jpg?itok=O6Um6eRe", linkURL: "https://www.nature.com/articles/d41586-018-07586-5", date: "Thu 23rd Jan, 12:00PM"))
        
    }
    
}

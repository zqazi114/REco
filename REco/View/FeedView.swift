//
//  FeedView.swift
//  REco
//
//  Created by Dev Macbook on 11/21/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import UIKit

enum ActivityType {
    case Recycle, Community, Restaurant, Undefined
}

extension ActivityType {
    var color : UIColor {
        switch self {
        case .Recycle:
            return UIColor.green
        case .Community:
            return UIColor.blue
        case .Restaurant:
            return UIColor.yellow
        default:
            return UIColor.red
        }
    }
}

class FeedView: UIView,
                UITableViewDelegate, UITableViewDataSource,
UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let RowHeight: CGFloat = 150.0
    
    var feedController: FeedViewController
    var mainView: UIView
    
    var scrollContainer: UIScrollView?
    var newsCollection: UICollectionView?
    var localTable: UITableView?
    var recTable: UITableView?
    var tableView: UITableView?
    
    var margin: CGFloat?
    var newsTitleYPos: CGFloat?
    var newsYPos: CGFloat?
    var newsHeight: CGFloat?
    var localTitleYPos: CGFloat?
    var localTableYPos: CGFloat?
    var localTableHeight: CGFloat?
    var recTitleYPos: CGFloat?
    var recYPos: CGFloat?
    var recHeight: CGFloat?
    
    var posts: [FeedPost] = []
    var articles: [NewsArticle] = []
    var events: [Event] = []
    
    init(controller: FeedViewController, view: UIView) {
        
        self.feedController = controller
        self.mainView = view
        
        super.init(frame: view.frame)
        
        setYPosAndHeights()
        
        initializeScrollContainer()
        initializeNewsBar()
        initializeLocalFeed()
        initializeRecFeed()
        
        self.mainView.addSubview(self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.feedController = FeedViewController()
        self.mainView = UIView()
        super.init(coder: aDecoder)
    }
    
    func setYPosAndHeights() {
        
        margin = 20//RowHeight/10
        
        newsTitleYPos = margin!
        newsYPos = newsTitleYPos! + HEADERHEIGHT
        newsHeight = 150.0
        
        localTitleYPos = newsYPos! + newsHeight! + margin!
        localTableYPos = localTitleYPos! + HEADERHEIGHT
        localTableHeight = SHEIGHT*0.7
        
        recTitleYPos = localTableYPos! + localTableHeight! + margin!
        recYPos = recTitleYPos! + HEADERHEIGHT
        recHeight = SHEIGHT*0.7
        
    }
    
    func initializeScrollContainer() {
        
        let frame = CGRect(x: 0.0, y: 0.0, width: WIDTH, height: HEIGHT)
        
        scrollContainer = UIScrollView(frame: frame)
        scrollContainer!.contentSize = CGSize(width: SWIDTH, height: 2*SHEIGHT)
        scrollContainer!.backgroundColor = BLUE
        
        self.addSubview(scrollContainer!)
        
    }
    
    func initializeNewsBar() {
        
        let title = self.makeHeader(with: "Top Stories", y: newsTitleYPos!, color: UIColor.white)
        title.backgroundColor = UIColor.clear
        
        let frame = CGRect(x: 10.0, y: newsYPos!, width: SWIDTH - 20.0, height: newsHeight!)
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0)
        
        newsCollection = UICollectionView(frame: frame, collectionViewLayout: layout)
        newsCollection!.backgroundColor = UIColor.clear
        newsCollection!.allowsSelection = true
        newsCollection!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "newscell")
        newsCollection!.delegate = self
        newsCollection!.dataSource = self
        
        scrollContainer!.addSubview(title)
        scrollContainer!.addSubview(newsCollection!)
        
    }
    
    func initializeLocalFeed() {
        
        let title = self.makeHeader(with: "Local", y: localTitleYPos!, color: UIColor.white)
        title.backgroundColor = UIColor.clear
        
        let frame = CGRect(x: 0.0, y: localTableYPos!, width: SWIDTH, height: localTableHeight!)
        
        localTable = UITableView(frame: frame)
        localTable!.rowHeight = 200.0
        localTable!.backgroundColor = UIColor.clear
        localTable!.register(UITableViewCell.self, forCellReuseIdentifier: "feedcell")
        localTable!.delegate = self
        localTable!.dataSource = self
        
        scrollContainer!.addSubview(title)
        scrollContainer!.addSubview(localTable!)
        
    }
    
    func initializeRecFeed() {
        
        let title = self.makeHeader(with: "Events", y: recTitleYPos!, color: UIColor.white)
        title.backgroundColor = UIColor.clear
        
        let frame = CGRect(x: 10.0, y: recYPos!, width: SWIDTH - 20.0, height: recHeight!)
        
        recTable = UITableView(frame: frame)
        recTable!.rowHeight = 200.0
        recTable!.backgroundColor = UIColor.clear
        recTable!.register(UITableViewCell.self, forCellReuseIdentifier: "reccell")
        recTable!.separatorStyle = .none
        recTable!.delegate = self
        recTable!.dataSource = self
        
        scrollContainer!.addSubview(title)
        scrollContainer!.addSubview(recTable!)
        
    }
    
    func updateFeed(posts: [FeedPost], articles: [NewsArticle], events: [Event]) {
        
        self.posts = posts
        self.articles = articles
        self.events = events
        
        newsCollection!.reloadData()
        localTable!.reloadData()
        recTable!.reloadData()
        
    }
    
    // -------------- Collection View --------------
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.newsCollection {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newscell", for: indexPath)
            cell.backgroundColor = UIColor.white
            
            for subview in cell.subviews {
                
                subview.removeFromSuperview()
                
            }
            
            let imageFrame = CGRect(x: 0.0, y: 0.0, width: 80, height: 150)
            let titleFrame = CGRect(x: 5.0, y: 100.0, width: 70, height: 50.0)
            
            let imageView = UIImageView(frame: imageFrame)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.downloaded(from: articles[indexPath.row].imageURL)
            
            let title = UILabel(frame: titleFrame)
            title.font = UIFont(name: "Cochin-Bold", size: 12.0)
            title.numberOfLines = 4
            title.textColor = UIColor.white
            title.text = articles[indexPath.row].name
            
            cell.addSubview(imageView)
            cell.addSubview(title)
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newscell", for: indexPath)
            cell.backgroundColor = UIColor.white
            
            for subview in cell.subviews {
                
                subview.removeFromSuperview()
                
            }
            
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let url = URL(string: articles[indexPath.row].linkURL) else { return }
        UIApplication.shared.open(url, options: [:]) { (compelted) in
            
            
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80.0, height: 150.0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return articles.count
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    // -------------- Table View --------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == localTable {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "feedcell")!
            cell.backgroundColor = UIColor.white
            
            for subview in cell.subviews {
                
                subview.removeFromSuperview()
                
            }
            
            let imageSize = 80.0
            let nameSize = 20.0
            let tagSize = 15.0
            
            let imageFrame = CGRect(x: 10.0, y: 10.0, width: imageSize, height: imageSize)
            let nameFrame = CGRect(x: 10.0+imageSize+10.0, y: 10.0+imageSize/2-nameSize, width: 100.0, height: nameSize)
            let tagFrame = CGRect(x: 10.0+imageSize+10.0, y: 10.0+imageSize/2+5.0, width: 100.0, height: tagSize)
            let contentFrame = CGRect(x: 10.0+imageSize+10.0, y: 10.0+imageSize/2+5.0, width: WIDTH-20.0-imageSize-20.0, height: 200-10.0-15-imageSize/2-20.0)
            let timeFrame = CGRect(x: 20.0, y: 200-30, width: WIDTH-20.0, height: 20)
            
            let imageView = UIImageView(frame: imageFrame)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = CGFloat(imageSize)/2
            imageView.image = posts[indexPath.row].image
            
            let name = UILabel(frame: nameFrame)
            name.font = UIFont(name: "Cochin", size: 20.0)
            name.textAlignment = .left
            name.text = posts[indexPath.row].author
            
            let tag = UILabel(frame: tagFrame)
            tag.font = UIFont(name: "Cochin", size: 15.0)
            tag.textAlignment = .left
            tag.textColor = UIColor.lightGray
            tag.text = "@" + posts[indexPath.row].author
            
            let content = UILabel(frame: contentFrame)
            content.font = UIFont(name: "Cochin", size: 25.0)
            content.textAlignment = .left
            content.numberOfLines = 5
            content.text = posts[indexPath.row].content
            
            let time = UILabel(frame: timeFrame)
            time.font = UIFont(name: "Cochin", size: 15.0)
            time.textAlignment = .left
            time.textColor = UIColor.lightGray
            time.text = posts[indexPath.row].time
            
            cell.addSubview(imageView)
            cell.addSubview(name)
            cell.addSubview(tag)
            cell.addSubview(content)
            cell.addSubview(time)
            
            return cell
            
        } else if tableView == recTable {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "reccell")!
            cell.backgroundColor = UIColor.clear
            
            for subview in cell.subviews {
                
                subview.removeFromSuperview()
                
            }
            
            let imageFrame = CGRect(x: 10.0, y: 10.0, width: SWIDTH - 20.0, height: 180.0)
            let titleFrame = CGRect(x: 20.0, y: 120.0, width: SWIDTH - 40.0, height: 40.0)
            let dateFrame = CGRect(x: 20.0, y: 160.0, width: SWIDTH - 40.0, height: 20.0)
            
            let imageView = UIImageView(frame: imageFrame)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.downloaded(from: events[indexPath.row].imageURL)
            
            let title = UILabel(frame: titleFrame)
            title.font = UIFont(name: "Cochin-Bold", size: 20.0)
            title.numberOfLines = 2
            title.textColor = UIColor.white
            title.text = events[indexPath.row].name
            
            let date = UILabel(frame: dateFrame)
            date.font = UIFont(name: "Cochin-Bold", size: 17.0)
            date.textColor = UIColor.white
            date.text = events[indexPath.row].date
            
            cell.addSubview(imageView)
            cell.addSubview(title)
            cell.addSubview(date)
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "feedcell")!
            cell.backgroundColor = UIColor.white
            
            for subview in cell.subviews {
                
                subview.removeFromSuperview()
                
            }
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == localTable {
            
            return posts.count
            
        } else if tableView == recTable {
            
            return events.count
            
        } else {
            
            return 1
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }

}

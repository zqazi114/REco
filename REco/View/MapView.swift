//
//  MapView.swift
//  REco
//
//  Created by Dev Macbook on 12/24/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView,
               UITableViewDelegate, UITableViewDataSource,
               UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let rankings = ["A", "B", "C", "D", "F"]
    let filters = ["salad", "sandwich", "coffee", "burger", "burrito", "chinese", "farm"]
    let results = ["sweetgreen", "dig inn", "chipotle", "little beet", "le pain quotidien"]
    let icons = ["biodegradable", "plastic free", "no straws", "renewable", "net zero"]
    
    
    var mapController: MapViewController
    var mainView: UIView
    
    var map: Map?
    var searchView: UIView?
    var searchField: UITextField?
    var detailContainer: UIView?
    var detailView: UIScrollView?
    var rankingCollection: UICollectionView?
    var filterCollection: UICollectionView?
    var resultsTable: UITableView?
    var iconCollections: [UICollectionView] = []
    
    var detailCenter: CGPoint = CGPoint(x: 0.0, y: 0.0)
    
    var spacing: CGFloat?
    var rankingYPos: CGFloat?
    var rankingHeight: CGFloat?
    var filterYPos: CGFloat?
    var filterHeight: CGFloat?
    var resultsYPos: CGFloat?
    var resultsHeight: CGFloat?
    
    var restaurants: ArraySlice<YelpRestaurant> = []
    var filteredRestaurants: ArraySlice<YelpRestaurant> = []
    
    var selectedRanking = -1
    var selectedFilter = -1
    
    init(controller: MapViewController, mainView: UIView) {
        
        self.mapController = controller
        self.mainView = mainView
        
        super.init(frame: mainView.bounds)
        
        setYPosAndHeights()
        
        initializeMap()
        initializeDetailView()
        initializeEcoRanking()
        initializeFilterCollection()
        initializResultsTable()
        
        self.backgroundColor = BLUE
        
        mainView.addSubview(self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.mapController = MapViewController()
        self.mainView = UIView()
        super.init(coder: aDecoder)
    }
    
    func setYPosAndHeights() {
        
        spacing = 10.0
        
        rankingYPos = spacing! + HEADERHEIGHT
        rankingHeight = 100.0
        
        filterYPos = rankingYPos! + rankingHeight! + spacing!
        filterHeight = 200.0
        
        resultsYPos = filterYPos! + filterHeight! + spacing!
        resultsHeight = SHEIGHT - resultsYPos! - spacing!
        
    }
    
    func initializeMap() {
        
        let mapFrame = CGRect(x: 0,
                              y: 0,
                              width: WIDTH,
                              height: HEIGHT)
        
        
        map = Map(frame: mapFrame)
        
        self.addSubview(map!)
        
    }
    
    func updateMap(with restaurants: ArraySlice<YelpRestaurant>) {
    
        self.restaurants = restaurants
        self.filteredRestaurants = restaurants
        resultsTable!.reloadData()
        
        map!.addAnnotationsForRestaurants(restaurants: restaurants)
        
    }
    
    func updateFilteredRestaurants(with ranking: Int?, filter: Int?) {
        
        self.filteredRestaurants = []
        
        if let _ = ranking {
            
            self.selectedRanking = ranking!
            
            if ranking != -1 {
                
                for idx in 0..<restaurants.count {
                    
                    if restaurants[idx].ranking! == self.selectedRanking {
                        
                        filteredRestaurants.append(restaurants[idx])
                        
                    }
                    
                }
                
            } else {
                
                self.filteredRestaurants = restaurants
                
            }
            
        }
        
        if let _ = filter {
            
            self.selectedFilter = filter!
            
            var res: ArraySlice<YelpRestaurant> = []
            
            if filter != -1 {
                
                for idx in 0..<filteredRestaurants.count {
                    
                    if filteredRestaurants[idx].cuisine! == self.selectedFilter {
                        
                        res.append(restaurants[idx])
                        
                    }
                    
                }
                
                filteredRestaurants = res
                
            }
            
        }
        
        resultsTable!.reloadData()
        
    }
    
    func initializeDetailView() {
        
        let containerFrame = CGRect(x: 0.0,
                                   y: SHEIGHT - 500.0,
                                   width: SWIDTH,
                                   height: SHEIGHT)
        let searchFrame = CGRect(x: SPACING/2,
                               y: -50.0/2,
                               width: WIDTH - SPACING,
                               height: 50.0)
        let searchTextFrame = CGRect(x: SPACING/2,
                                     y: 0.0,
                                     width: WIDTH - 2*SPACING,
                                     height: 50.0)
        let detailFrame = CGRect(x: 0.0,
                                 y: SPACING,
                                 width: WIDTH,
                                 height: HEIGHT - 2*SPACING)
        
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(self.detailPanned(gestureRecognizer:)))
        
        searchField = UITextField(frame: searchTextFrame)
        searchField!.backgroundColor = UIColor.white
        searchField!.placeholder = "Search"
        searchField!.borderStyle = .none
        
        searchView = UIView(frame: searchFrame)
        searchView!.backgroundColor = UIColor.white
        searchView!.layer.shadowColor = UIColor.black.cgColor
        searchView!.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        searchView!.layer.masksToBounds = false
        searchView!.layer.shadowOpacity = 0.5
        searchView!.addSubview(searchField!)
        
        detailView = UIScrollView(frame: detailFrame)
        detailView!.backgroundColor = BLUE
        
        let tabWidth = 50.0
        let tabHeight = 5.0
        let tabXPos = (WIDTH - tabWidth)/2
        let tabYPos = SPACING - 15.0
        let tabLine = UIView(frame: CGRect(x: tabXPos, y: tabYPos, width: tabWidth, height: tabHeight))
        tabLine.layer.cornerRadius = CGFloat(tabHeight)/2
        tabLine.backgroundColor = UIColor.darkGray
        
        detailContainer = UIView(frame: containerFrame)
        detailContainer!.backgroundColor = UIColor.white
        detailContainer!.addSubview(tabLine)
        detailContainer!.addSubview(searchView!)
        detailContainer!.addSubview(detailView!)
        detailContainer!.addGestureRecognizer(panGR)
        
        self.addSubview(detailContainer!)
        
    }
    
    @objc func detailPanned(gestureRecognizer: UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            
            detailCenter = detailContainer!.center
            
        } else if gestureRecognizer.state == .changed {
        
            let newY = detailCenter.y + gestureRecognizer.translation(in: self).y
            let newCenter = CGPoint(x: detailCenter.x, y: newY)
            
            if newY < CGFloat(HEIGHT - 2*SPACING)*1.5 && newY > 100 + SHEIGHT/2 {
            
                detailContainer!.center = newCenter
                
            }
            
        }
        
    }
    
    func initializeEcoRanking() {
        
        let header = self.makeHeader(with: "Ranking", y: spacing!)
        
        let frame = CGRect(x: 0.0,
                           y: rankingYPos!,
                           width: SWIDTH,
                           height: rankingHeight!)
        
        let sidemargin = SWIDTH/36
        let topmargin = (rankingHeight! - SWIDTH/6)/2
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: topmargin, left: sidemargin/2, bottom: 0, right: sidemargin/2)
        
        rankingCollection = UICollectionView(frame: frame, collectionViewLayout: layout)
        rankingCollection!.backgroundColor = UIColor.white
        rankingCollection!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "rankingcell")
        rankingCollection!.allowsMultipleSelection = false
        rankingCollection!.isPagingEnabled = true
        rankingCollection!.delegate = self
        rankingCollection!.dataSource = self
        
        self.detailView!.addSubview(header)
        self.detailView!.addSubview(rankingCollection!)
        
    }
    
    func initializeFilterCollection() {
    
        let frame = CGRect(x: 0.0,
                           y: filterYPos!,
                           width: SWIDTH,
                           height: filterHeight!)
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        filterCollection = UICollectionView(frame: frame, collectionViewLayout: layout)
        filterCollection!.backgroundColor = UIColor.white
        filterCollection!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "filtercell")
        filterCollection!.allowsMultipleSelection = true
        filterCollection!.isPagingEnabled = true
        filterCollection!.delegate = self
        filterCollection!.dataSource = self
        
        self.detailView!.addSubview(filterCollection!)
        
    }
    
    func initializResultsTable() {
        
        let frame = CGRect(x: 0.0,
                           y: resultsYPos!,
                           width: SWIDTH,
                           height: resultsHeight!)
        
        resultsTable = UITableView(frame: frame)
        resultsTable!.backgroundColor = UIColor.white
        resultsTable!.rowHeight = 150.0
        resultsTable!.register(UITableViewCell.self, forCellReuseIdentifier: "resultcell")
        resultsTable!.delegate = self
        resultsTable!.dataSource = self
        
        self.detailView!.addSubview(resultsTable!)
        
    }
    
    // -------------- Collection View --------------
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.filterCollection! {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filtercell", for: indexPath)
            cell.backgroundColor = UIColor.white
            
            let frame = cell.bounds
            
            let iconSize = frame.width*0.66
            let labelHeight = CGFloat(20.0)
            
            let imageView = UIImageView(frame: CGRect(x: (frame.width - iconSize)/2, y: (frame.height - iconSize)/2, width: iconSize, height: iconSize))
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: filters[indexPath.row])
            
            let descriptionLabel = UILabel(frame: CGRect(x: 0, y: frame.height-labelHeight+5, width: frame.width, height: labelHeight))
            descriptionLabel.textAlignment = .center
            descriptionLabel.font = UIFont(name: "Cochin", size: 10.0)
            descriptionLabel.minimumScaleFactor = 0.5
            descriptionLabel.adjustsFontSizeToFitWidth = true
            descriptionLabel.text = filters[indexPath.row]
            
            cell.addSubview(imageView)
            cell.addSubview(descriptionLabel)
            
            return cell
            
        } else if collectionView == self.rankingCollection {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rankingcell", for: indexPath)
            cell.backgroundColor = UIColor.white
            
            let frame = cell.bounds
            
            let iconSize = frame.width
            
            let imageView = UIImageView(frame: CGRect(x: (frame.width - iconSize)/2, y: (frame.height - iconSize)/2, width: iconSize, height: iconSize))
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: rankings[indexPath.row])
            
            cell.addSubview(imageView)
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconcell", for: indexPath)
            cell.backgroundColor = UIColor.white
            
            let frame = cell.bounds
            
            let iconSize = frame.width*0.66
            let labelHeight = CGFloat(20.0)
            
            let imageView = UIImageView(frame: CGRect(x: (frame.width - iconSize)/2, y: (frame.height - iconSize)/2, width: iconSize, height: iconSize))
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: icons[indexPath.row])
            
            let descriptionLabel = UILabel(frame: CGRect(x: 0, y: frame.height-labelHeight+5, width: frame.width, height: labelHeight))
            descriptionLabel.textAlignment = .center
            descriptionLabel.font = UIFont(name: "Cochin-Bold", size: 10.0)
            descriptionLabel.text = icons[indexPath.row]
            
            cell.addSubview(imageView)
            cell.addSubview(descriptionLabel)
            
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        
        if collectionView == self.filterCollection! {
            
            cell.backgroundColor = BLUE
            
        } else if collectionView == self.rankingCollection {
            
            cell.backgroundColor = BLUE
            
        } else {
            
            
            
        }
        
        updateFilteredRestaurants(with: indexPath.row, filter: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        
        if collectionView == self.filterCollection! {
            
            cell.backgroundColor = UIColor.white
            
        } else if collectionView == self.rankingCollection {
            
            cell.backgroundColor = UIColor.white
            
        } else {
            
            
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.filterCollection! {
            
            return CGSize(width: 80.0, height: 80.0)
    
        } else if collectionView == self.rankingCollection {
            
            return CGSize(width: SWIDTH/6, height: SWIDTH/6)
            
        }  else {
    
            return CGSize(width: 40.0, height: 40.0)
    
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.filterCollection! {
            
            return filters.count
        
        }  else if collectionView == self.rankingCollection {
            
            return rankings.count
            
        } else {
            
            return icons.count
            
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if collectionView == self.filterCollection! {
            
            return 1
        
        }  else if collectionView == self.rankingCollection {
            
            return 1
            
        } else {
            
            return 1
            
        }
        
    }
    
    // -------------- Table View --------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultcell")!
        cell.backgroundColor = UIColor.white
        
        for subview in cell.subviews {
            
            subview.removeFromSuperview()
            
        }
        
        let imageSize = CGFloat(140.0)
        let imageFrame = CGRect(x: 10.0,
                                y: 5.0,
                                width: imageSize,
                                height: imageSize)
        let titleFrame = CGRect(x: 10.0 + imageSize + 10.0,
                                y: 5.0,
                                width: SWIDTH - 40 - imageSize - 52,
                                height: 25.0)
        let cuisineFrame = CGRect(x: 10.0 + imageSize + 10.0,
                                  y: 5.0 + 25.0,
                                  width: SWIDTH - 40 - imageSize,
                                  height: 17.0)
        let rankingFrame = CGRect(x: SWIDTH - 32 - 20,
                                  y: 5.0,
                                  width: 32,
                                  height: 32)
        let iconsFrame = CGRect(x: 10.0 + imageSize + 10.0,
                                y: 5.0 + 25.0 + 10.0 + 5.0,
                                width: SWIDTH - 40 - imageSize,
                                height: 150.0 - 40.0)
        
        let imageView = UIImageView(frame: imageFrame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.downloaded(from: filteredRestaurants[indexPath.row].image_url)
        
        let title = UILabel(frame: titleFrame)
        title.font = UIFont(name: "Cochin-Bold", size: 25.0)
        title.textAlignment = .left
        title.minimumScaleFactor = 0.5
        title.adjustsFontSizeToFitWidth = true
        title.text = filteredRestaurants[indexPath.row].name
        
        let cuisine = UILabel(frame: cuisineFrame)
        cuisine.font = UIFont(name: "Cochin", size: 17.0)
        cuisine.textAlignment = .left
        cuisine.minimumScaleFactor = 0.5
        cuisine.text = filters[filteredRestaurants[indexPath.row].cuisine!]
        
        let ranking = UIImageView(frame: rankingFrame)
        ranking.contentMode = .scaleAspectFit
        ranking.image = UIImage(named: rankings[filteredRestaurants[indexPath.row].ranking!])
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        let iconCollection = UICollectionView(frame: iconsFrame, collectionViewLayout: layout)
        iconCollection.backgroundColor = UIColor.white
        iconCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "iconcell")
        iconCollection.allowsMultipleSelection = true
        iconCollection.isPagingEnabled = true
        iconCollection.delegate = self
        iconCollection.dataSource = self
        
        iconCollections.append(iconCollection)
        
        cell.addSubview(imageView)
        cell.addSubview(title)
        cell.addSubview(cuisine)
        cell.addSubview(ranking)
        cell.addSubview(iconCollection)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: filteredRestaurants[indexPath.row].url) else { return }
        UIApplication.shared.open(url, options: [:]) { (compelted) in
            
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return self.makeHeader(with: "Recommendations", y: 0.0)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60.0
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredRestaurants.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIView {
    func makeHeader(with titleStr: String, y: CGFloat) -> UIView {
        
        let titleHeight: CGFloat = 25.0
        
        let frame = CGRect(x: 0.0, y: y, width: SWIDTH, height: HEADERHEIGHT)
        let titleFrame = CGRect(x: 20.0, y: (HEADERHEIGHT-titleHeight)/2, width: SWIDTH, height: titleHeight)
        
        let title = UILabel(frame: titleFrame)
        title.font = UIFont(name: "GillSans-Bold", size: 25.0)
        title.textAlignment = .left
        title.text = titleStr
        
        let header = UIView(frame: frame)
        header.backgroundColor = UIColor.white
        header.addSubview(title)
        header.clipsToBounds = false
        
        return header
        
    }
    
    func makeHeader(with titleStr: String, y: CGFloat, color: UIColor) -> UIView {
        
        let titleHeight: CGFloat = 25.0
        
        let frame = CGRect(x: 0.0, y: y, width: SWIDTH, height: HEADERHEIGHT)
        let titleFrame = CGRect(x: 20.0, y: (HEADERHEIGHT-titleHeight)/2, width: SWIDTH, height: titleHeight)
        
        let title = UILabel(frame: titleFrame)
        title.font = UIFont(name: "GillSans-Bold", size: 25.0)
        title.textColor = color
        title.textAlignment = .left
        title.text = titleStr
        
        let header = UIView(frame: frame)
        header.backgroundColor = UIColor.white
        header.addSubview(title)
        header.clipsToBounds = false
        
        return header
        
    }
}

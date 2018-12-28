//
//  YelpManager.swift
//  Chivalry
//
//  Created by Dev Macbook on 7/24/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import Foundation
import Firebase
import Alamofire

struct YelpRestaurant {
    
    var id: String
    var name: String
    var rating: Double
    var phone: String
    var image_url: String
    var url: String
    var price: String
    var location: NSDictionary
    var ranking: Int?
    var cuisine: Int?
    
    init(id: String, name: String, rating: Double, phone: String, image_url: String, url: String, price: String, location: NSDictionary) {
        
        self.id = id
        self.name = name
        self.rating = rating
        self.phone = phone
        self.image_url = image_url
        self.url = url
        self.price = price
        self.location = location
        
    }
    
}

class YelpManager: NSObject {
    
    let CITY = "NEW-YORK"
    
    var controller: ViewController
    var controllerType: ControllerType
    
    var ref: DatabaseReference
    
    var appKey: String?
    var clientID: String?
    var apiHost: String?
    var businessPath: String?
    var searchPath: String?
    
    var restaurants: [YelpRestaurant] = []
    
    
    init(controller: ViewController, type: ControllerType) {
        
        self.controller = controller
        self.controllerType = type
        self.ref = Database.database().reference()
        
        super.init()
        
        //saveTESTYelpAppIDToFirebase()
        getYelpAppIDFromFirebase()
        
    }
    
    func getYelpAppIDFromFirebase() {
        
        let path = "configuration/yelp"
        
        ref.child(path).observeSingleEvent(of: .value) { (snapshot) in
            
            if let configDict = snapshot.value as? NSDictionary {
                
                let appKey = configDict.value(forKey: "app-key") as! String
                let clientID = configDict.value(forKey: "client-id") as! String
                let apiHost = configDict.value(forKey: "api-host") as! String
                let businessPath = configDict.value(forKey: "business-path") as! String
                
                self.appKey = appKey
                self.clientID = clientID
                self.apiHost = apiHost
                self.businessPath = businessPath
                self.searchPath = "\(businessPath)/search"
                
                self.findRestaurantsOnYelp(location: self.CITY, price: 1)
                
            }
            
        }
        
        
    }
    
    func findRestaurantsOnYelp(location: String, price: Int) {
        
        let locationFormatted = formatLocation(location: location)
        let radius = 10000
        let urlString = "\(apiHost!)\(searchPath!)?location=\(locationFormatted)&radius=\(radius)&price=\(price)"
        let url = URL(string: urlString)!
        let method = HTTPMethod.get
        let parameters: Parameters? = ["location"   : location,
                                       "radius"     : radius,
                                       "price"      : price,
                                       ]
        let encoding = JSONEncoding.default
        let headers: HTTPHeaders? = ["Authorization" : "Bearer \(appKey!)"]
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (response) in
            
            if let error = response.error {
                
                ErrorView.displayError(mainView: self.controller.view, message: "We ran into an issue connecting with Yelp. Please try again later.")
                
                print("ERROR: \(error.localizedDescription)")
                
            }
            
            if let jsonResponse = response.result.value as? NSDictionary {
                
                if let restaurantsArr = jsonResponse["businesses"] as? [NSDictionary] {
                    
                    for restaurant in restaurantsArr {
                        
                        let id = restaurant.value(forKey: "id") as! String
                        let name = restaurant.value(forKey: "name") as! String
                        let rating = restaurant.value(forKey: "rating") as! Double
                        let phone = restaurant.value(forKey: "phone") as! String
                        let image_url = restaurant.value(forKey: "image_url") as! String
                        let url = restaurant.value(forKey: "url") as! String
                        let price = restaurant.value(forKey: "price") as! String
                        let location = restaurant.value(forKey: "location") as! NSDictionary
                        let ranking = Int.random(in: 0..<5)
                        let cuisine = Int.random(in: 0..<7)
                        
                        var yelpRestaurant = YelpRestaurant(id: id, name: name, rating: rating, phone: phone, image_url: image_url, url: url, price: price, location: location)
                        yelpRestaurant.ranking = ranking
                        yelpRestaurant.cuisine = cuisine
                        
                        self.restaurants.append(yelpRestaurant)
                        
                    }
                    
                    switch self.controllerType {
                    case .map:
                        guard let mvc = self.controller as? MapViewController else {
                            return
                        }
                        mvc.restaurantsRetrievedNotification()
                    default:
                        print("ERROR: Unsupported controller")
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func formatLocation(location: String) -> String {
        
        var formattedLocation = location
        
        if let index = location.index(of: " ") {
            
            formattedLocation = formattedLocation.replacingOccurrences(of: " ", with: "")
            
        }
        
        return formattedLocation
        
    }
    
    func saveTESTYelpAppIDToFirebase() {
        
        let path = "configuration/yelp"
        
        let apiKey = "eHEu8s2uijmx-_bty86VCJM6M1tIVwClaqiFkl7aH__Z6WteK4eFUxM5B2G8bTbzEESYkaztsmt8T15wVKOTbJ8xShSQtoEsJgkgxW5P-GtZp-AgCCRgQB2KZOFWW3Yx"
        let clientID = "JW8xy2XrxyY81Qw7fenWOA"
        let apiHost = "https://api.yelp.com"
        let businessPath = "/v3/businesses"
        
        ref.child(path).child("app-key").setValue(apiKey)
        ref.child(path).child("client-id").setValue(clientID)
        ref.child(path).child("api-host").setValue(apiHost)
        ref.child(path).child("business-path").setValue(businessPath)
        
    }
    
}

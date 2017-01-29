//
//  Photo.swift
//  FlickrClient
//
//  Created by Omer on 29/01/2017.
//  Copyright © 2017 Omer. All rights reserved.
//

import Foundation

class Photo : NSObject {
    private(set) var id: String!
    private(set) var owner: Owner!
    private(set) var secret: String!
    private(set) var server: String!
    private(set) var farm: Int!
    private(set) var title: String!
    private(set) var isPublic: Bool! = true
    private(set) var isFriend: Bool! = false
    private(set) var isFamily: Bool! = false
    
    
    //MARK: Setters
    func setId(id: String) {
        self.id = id
    }
    
    func setOwner(owner: Owner) {
        self.owner = owner
    }
    
    func setSecret(secret: String) {
        self.secret = secret
    }
    
    func setServer(server: String) {
        self.server = server
    }
    
    func setFarm(farm: Int) {
        self.farm = farm
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func setIsPublic(isPublic: Bool) {
        self.isPublic = isPublic
    }
    
    func setIsFriend(isFriend: Bool) {
        self.isFriend = isFriend
    }
    
    func setIsFamily(isFamily: Bool) {
        self.isFamily = isFamily
    }
}

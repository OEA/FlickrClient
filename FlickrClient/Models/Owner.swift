//
//  Owner.swift
//  FlickrClient
//
//  Created by Omer on 29/01/2017.
//  Copyright © 2017 Omer. All rights reserved.
//

import Foundation

class Owner : NSObject {
    private(set) var id: String!
    private(set) var username: String!
    private(set) var realName: String!
    private(set) var location: String!
    private(set) var iconServer: String!
    private(set) var iconFarm: Int!
//    "owner": { "nsid": "41059954@N00", "username": "Zinkr", "realname": "Jenny", "location": "Grinnell, Iowa, USA", "iconserver": "5584", "iconfarm": 6, "path_alias": "zinkr" },
    
    func setId(id: String) {
        self.id = id
    }
    
    func setUsername(userName: String) {
        self.username = userName
    }
    
    func setRealName(realName: String) {
        self.realName = realName
    }
    
    func setLocation(location: String) {
        self.location = location
    }
    
    func setIconServer(iconServer: String) {
        self.iconServer = iconServer
    }
    
    func setIconFarm(iconFarm: Int) {
        self.iconFarm = iconFarm
    }
    
}

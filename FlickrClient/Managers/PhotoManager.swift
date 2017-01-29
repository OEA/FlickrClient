//
//  PhotoManager.swift
//  FlickrClient
//
//  Created by Omer on 29/01/2017.
//  Copyright © 2017 Omer. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private enum UrlMethods : String {
    case recent = "flickr.photos.getRecent"
    case photoDetail = "flickr.photos.getInfo"
    case search = "flickr.photos.search"
}

class PhotoManager : NSObject {
    
    //It could be improved with seperating apiKey from baseUrl
//    private let apiKey = "ec660d49a08bde10ec28f3a6faf6b809"
    private let baseUrl = "https://api.flickr.com/services/rest/?api_key=ec660d49a08bde10ec28f3a6faf6b809&format=json&nojsoncallback=1"
    
    //Prevent object creation for using singleton instance
    private override init() {}
    
    static let sharedInstance : PhotoManager = {
        let instance = PhotoManager()
        return instance
    }()
    
    func getRecentPhotos(_ page: Int,
                         _ completion: @escaping ((_ photos: [Photo])->Void),
                         _ fail: @escaping (_ message: String)->Void) {
        
        let parameters = [
            "method": UrlMethods.recent.rawValue,
            "extras": "owner_name, icon_server, date_upload, date_taken",
            "page": "\(page)"
        ]
        Alamofire.request(baseUrl, method: .get, parameters: parameters).responseJSON { response in
            let json = JSON(response.result.value!)
            if json["stat"].stringValue == "fail" {
                fail(json["message"].stringValue)
                return
            }
            let photos = self.getPhotosFromJson(json["photos"]["photo"].arrayValue)
            completion(photos)
        }
    }
    
    func searchPhoto(_ keyword: String,
                     _ completion: @escaping ((_ photos: [Photo])->Void),
                     _ fail: @escaping (_ message: String)->Void) {
        let parameters = [
            "method": UrlMethods.search.rawValue,
            "extras": "owner_name, icon_server, date_upload, date_taken",
            "text": keyword
        ]
        Alamofire.request(baseUrl, method: .get, parameters: parameters).responseJSON { response in
            let json = JSON(response.result.value!)
            if json["stat"].stringValue == "fail" {
                fail(json["message"].stringValue)
                return
            }
            let photos = self.getPhotosFromJson(json["photos"]["photo"].arrayValue)
            completion(photos)
        }
    }
    
    func getPhotoURL(photo: Photo) -> String {
        return "http://farm\(photo.farm!).staticflickr.com/\(photo.server!)/\(photo.id!)_\(photo.secret!).jpg"
    }
    
    func getBuddiesURL(owner: Owner) -> String {
        if Int(owner.iconServer)! > 0 {
            return "http://farm\(owner.iconFarm!).staticflickr.com/\(owner.iconServer!)/buddyicons/\(owner.id!).jpg"
        } else {
            return "https://www.flickr.com/images/buddyicon.gif"
        }
    }
    
}
//MARK: Parsing JSON
extension PhotoManager {
    func getPhotosFromJson(_ json: [JSON]) -> [Photo] {
        var photoArray: [Photo] = []
        for photoJson in json {
            let photo = Photo()
            photo.setId(id: photoJson["id"].stringValue)
            photo.setOwner(owner: self.getOwnerFromJson(photoJson))
            photo.setSecret(secret: photoJson["secret"].stringValue)
            photo.setServer(server: photoJson["server"].stringValue)
            photo.setFarm(farm: photoJson["farm"].intValue)
            photo.setTitle(title: photoJson["title"].stringValue)
            photo.setIsFamily(isFamily: photoJson["isfamily"].boolValue)
            photo.setIsPublic(isPublic: photoJson["isPublic"].boolValue)
            photo.setIsFriend(isFriend: photoJson["isFriend"].boolValue)
            let uploadDate = Date(timeIntervalSince1970: Double(photoJson["dateupload"].stringValue)!)
            let strTime = photoJson["datetaken"].stringValue
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let takenDate: Date! = formatter.date(from: strTime)
            photo.setUploadTime(uploadTime: uploadDate)
            photo.setTakenTime(takenTime: takenDate)
            photoArray.append(photo)
        }
        return photoArray
    }
    
    func getOwnerFromJson(_ json: JSON) -> Owner {
        let owner = Owner()
        owner.setId(id: json["owner"].stringValue)
        owner.setIconFarm(iconFarm: json["iconfarm"].intValue)
        owner.setIconServer(iconServer: json["iconserver"].stringValue)
        owner.setRealName(realName: json["ownername"].stringValue)
        return owner
    }
}

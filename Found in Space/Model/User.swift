//
//  CurrentUser.swift
//  Found in Space
//
//  Created by Theo Mendes on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import Foundation

//struct Restaurant {
//
//    var uid: String
//    var displayName: String
//    var achievements: Achievements
//    var photo: URL
//
//    var dictionary: [String: Any] {
//        return [
//            "uid": uid,
//            "displayName": displayName,
//            "achievements": achievements,
//            "photo": photo.absoluteString
//        ]
//    }
//
//}
//
//extension Restaurant: DocumentSerializable {
//
//    static func imageURL(forName name: String) -> URL {
//        let number = (abs(name.hashValue) % 22) + 1
//        let URLString =
//        "https://storage.googleapis.com/firestorequickstarts.appspot.com/food_\(number).png"
//        return URL(string: URLString)!
//    }
//
//    var imageURL: URL {
//        return Restaurant.imageURL(forName: uid)
//    }
//
//    init?(dictionary: [String : Any]) {
//        guard let uid = dictionary["uid"] as? String,
//            let displayName = dictionary["displayName"] as? String,
//            let achievements = dictionary["achievements"] as? Achievements,
//            let photo = (dictionary["photo"] as? String).flatMap(URL.init(string:)) else { return nil }
//
//        self.init(uid: uid,
//                  displayName: displayName,
//                  achievements: achievements,
//                  photo: photo)
//    }
//
//}

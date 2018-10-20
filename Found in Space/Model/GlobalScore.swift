//
//  UserScore.swift
//  Found in Space
//
//  Created by Theo Mendes on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import Foundation

struct GlobalScore {
    var uid: String
    var user: String
    var score: Int
    
    var dictionary: [String: Any] {
        return [
            "user": user,
            "score": score
        ]
    }
}

extension GlobalScore {
    init?(dictionary: [String: Any], uid: String) {
        guard  let user = dictionary["user"] as? String,
            let score = dictionary["score"] as? Int
            else { return nil }
        
        self.init(uid: uid, user: user, score: score)
    }
}

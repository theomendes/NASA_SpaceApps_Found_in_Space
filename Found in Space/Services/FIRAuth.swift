//
//  FIRAuth.swift
//  Found in Space
//
//  Created by Theo Mendes on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import Foundation
import Firebase

class FIRAuth {
    func signIn(withEmail: String, password: String, completion: ()) {
        Auth.auth().signIn(withEmail: withEmail, password: password) { (user, error) in
            if error != nil {
                debugPrint(#function, String(describing: error?.localizedDescription))
            } else {
                debugPrint(user)
            }
        }
    }
}

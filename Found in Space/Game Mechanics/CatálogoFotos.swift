//
//  CatálogoFotos.swift
//  Found in Space
//
//  Created by Julia Rocha on 21/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import Foundation


class CatálogoFotos {
    
    struct PhotoData {
        let photoID: String
        let photoName: String
        let photoDescription: String
    }
    
    let catalogo:[PhotoData] = [PhotoData.init(photoID: "foto1", photoName: "Cone Nebula (NGC 2264)", photoDescription: "Star-Forming Pillar of Gas and Dust")]
}

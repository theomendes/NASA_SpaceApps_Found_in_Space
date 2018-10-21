//
//  CatálogoFotos.swift
//  Found in Space
//
//  Created by Julia Rocha on 21/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import Foundation


class PhotoCatalog {
    
    struct PhotoData {
        let photoID: String
        let photoName: String
        let photoDescription: String
    }
    
    let catalog: [PhotoData] = [PhotoData.init(photoID: "foto1", photoName: "Cone Nebula (NGC 2264)", photoDescription: "Star-Forming Pillar of Gas and Dust"), PhotoData.init(photoID: "foto2", photoName: "Jupiter (2014)", photoDescription: "NASA, ESA, and A. Simon (Goddard Space Flight Center)") ]
}

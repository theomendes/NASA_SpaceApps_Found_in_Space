//
//  LevelData.swift
//  Found in Space
//
//  Created by pedro ferraz on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

struct StarData: Codable {
    let radius: Int
    let position: [Int]
    let strength: Float
    let diameter: Int
}

struct SpaceshipData: Codable {
    let index: Int
    let position: [Int]
    let radius: Float
}

struct LevelData: Codable {
    let levelID: String
    let stars: [StarData]
    let spaceship: SpaceshipData
}

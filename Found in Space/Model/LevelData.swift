//
//  LevelData.swift
//  Found in Space
//
//  Created by pedro ferraz on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

struct LevelData: Codable {
    let id: String
    let type: Int
    let gridSize: [Int]
    let plasmas: [[Int]]
    let obstacles: [[Int]]
    let ghost: [Int]
    let goal: Int
}

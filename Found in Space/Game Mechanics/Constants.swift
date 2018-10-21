//
//  Constants.swift
//  Found in Space
//
//  Created by pedro ferraz on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

struct Constants {
    static let shipTextures = ["apollo", "dreamchaser", "mercury", "shuttle"]
    
    static let starGravityCategory: UInt32 = 0x1 << 0
    static let spaceshipGravityCategory: UInt32 = 0x1 << 1
    static let starBodyCategory: UInt32 = 0x1 << 2
    static let spaceshipBodyCategory: UInt32 = 0x1 << 3
    static let hubbleBodyCategory: UInt32 = 0x1 << 4
}

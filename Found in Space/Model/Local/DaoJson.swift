//
//  DAOJSON.swift
//  Found in Space
//
//  Created by pedro ferraz on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import Foundation
// MARK: - Declaration

/**
 Singleton class that manages:
 * Loading of Level's data from JSON
 * Supply of Levels
 */
class DataAccess {
    
    // MARK: Singleton
    
    /// The single instance of `DataAccess`
    static let object = DataAccess()
    private init() { }
    
    // MARK: - Properties
    
    /// Stores an array with information of all levels.
    private lazy var levels: [LevelData] = loadLevels()
    
    // MARK: - Methods
    
    /// Loads the Levels saved in the Bundle's Levels.json file
    func loadLevels() -> [LevelData] {
        var levels = [LevelData]()
        let levelFileName = "Levels"
        guard let levelFilePath = Bundle.main.path(forResource: levelFileName, ofType: "json") else {
            return levels
        }
        let url = URL(fileURLWithPath: levelFilePath)
        
        do {
            let readData = try Data(contentsOf: url)
            levels = try JSONDecoder().decode([LevelData].self, from: readData)
        } catch {
            debugPrint("Couldn't load Levels File")
        }
        
        return levels
    }
}

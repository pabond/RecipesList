//
//  FileManager.swift
//  RecipesList
//
//  Created by Bondar Pavel on 1/5/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

extension FileManager {
    class func applicationDataPath(withFolderName name: String) -> String {
        let dataPath = libraryDirectoryPath() + "/\(name)"
        let fileManager = self.default
        if !fileManager.fileExists(atPath: dataPath) {
            do {
                try fileManager.createDirectory(atPath: dataPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return dataPath
    }
    
    class func libraryDirectoryPath() -> String {
        return self.pathWithDirectory(withDirectory: .libraryDirectory)
    }
    
    class func pathWithDirectory(withDirectory directory: FileManager.SearchPathDirectory) -> String {
        return self.pathsWithDirectory(withDirectory: directory)[0]
    }

    class func pathsWithDirectory(withDirectory directory: FileManager.SearchPathDirectory) -> Array<String> {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    }
}

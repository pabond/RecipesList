//
//  ImageModel.swift
//  RecipesList
//
//  Created by Bondar Pavel on 1/5/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import RxSwift

fileprivate let imagesFolder = "Images"

class ImageModel : Model {
    let observable = PublishSubject<UIImage>()
    
    var task: URLSessionTask? {
        get { return self.task }
        set {
            if task != newValue {
                task?.cancel()
                
                self.task = newValue
                task?.resume()
            }
        }
    }
    
    var url: URL?
    
    var localURL: URL? {
        get {
            guard let path = path else { return nil }
            
            return URL(fileURLWithPath: path)
        }
    }
    
    var path: String? {
        get {
            return FileManager.applicationDataPath(withFolderName: imagesFolder) + "/\(fileName)"
        }
    }
    
    var fileName: String? {
        get {
            return self.url?.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)
        }
    }
    
    var session: URLSession = URLSession.shared
    var downloadTaskCompletionHandler: (URL?, URLResponse?, Error?) -> () {
        get {
            return { [weak self] (location, response, error) in
                guard let url = self?.localURL, let location = location else {
                    return
                }
                do {
                    try FileManager.default.copyItem(at: location, to: url)
                } catch {
                    print(error.localizedDescription)
                }
                
                print("Image loaded from internet")
                let image = self?.localImageWithURL(location)
                
              //  [self finishLoadingImage:image];
            }
        }
    }
    
    deinit {
        self.task = nil
    }
    
    func localImageWithURL(_ url: URL?) -> UIImage? {
        var image: UIImage?
        url.map({ image = UIImage(contentsOfFile: $0.path)})
        
        return image
    }
    
    func removeCorruptedImage() {
        path.map({
            do {
                try FileManager.default.removeItem(atPath: $0)
            } catch {
                print(error.localizedDescription)
            }
        })
    }
    
    func imageWithURL(_ url: URL) { //Observable<UIImage>
        self.url = url
        var image: UIImage?
        image = localImageWithURL(localURL)
        if image == nil {
            removeCorruptedImage()
            loadFromInternet()
        }
    }
    
    func loadFromInternet() {
        url.map({ task = session.downloadTask(with: $0, completionHandler: downloadTaskCompletionHandler) })
    }
}

//
//  PersistencyManager.swift
//  BlueLibrarySwift
//
//  Created by Fábio Salata on 23/04/17.
//  Copyright © 2017 Raywenderlich. All rights reserved.
//

import UIKit

class PersistencyManager: NSObject {
    private var albums = [Album]()
    
    override init() {
        //Dummy list of albums
        let album1 = Album(title: "Best of Bowie",
                           artist: "David Bowie",
                           genre: "Pop",
                           coverUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/2/29/Best_of_bowie.jpg/220px-Best_of_bowie.jpg",
                           year: "1992")
        
        let album2 = Album(title: "It's My Life",
                           artist: "No Doubt",
                           genre: "Pop",
                           coverUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/2/29/Best_of_bowie.jpg/220px-Best_of_bowie.jpg",
                           year: "2003")
        
        let album3 = Album(title: "Nothing Like The Sun",
                           artist: "Sting",
                           genre: "Pop",
                           coverUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/2/29/Best_of_bowie.jpg/220px-Best_of_bowie.jpg",
                           year: "1999")
        
        let album4 = Album(title: "Staring at the Sun",
                           artist: "U2",
                           genre: "Pop",
                           coverUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/2/29/Best_of_bowie.jpg/220px-Best_of_bowie.jpg",
                           year: "2000")
        
        let album5 = Album(title: "American Pie",
                           artist: "Madonna",
                           genre: "Pop",
                           coverUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/2/29/Best_of_bowie.jpg/220px-Best_of_bowie.jpg",
                           year: "2000")
        
        albums = [album1, album2, album3, album4, album5]
    }
    
    func getAlbums() -> [Album] {
        return albums
    }
    
    func add(album: Album, at index: Int) {
        if (albums.count >= index) {
            albums.insert(album, at: index)
        } else {
            albums.append(album)
        }
    }
    
    func deleteAlbumAt(index: Int) {
        albums.remove(at: index)
    }
    
    func saveImage(image: UIImage, filename: String) {
        let path = NSHomeDirectory().appending("/Documents/\(filename)")
        let data = UIImagePNGRepresentation(image)
        do {
            try data?.write(to: URL(fileURLWithPath: path), options: .atomic)
        } catch {
            print(error)
        }
    }
    
    func getImage(filename: String) -> UIImage? {
        let path = NSHomeDirectory().appending("/Documents/\(filename)")
        var data: NSData?
        do {
            data = try NSData(contentsOfFile: path, options: .uncachedRead)
        }
        catch {
            print(error)
        }
        
        if (data != nil)  {
            return UIImage(data: data as Data!)
        }
        else {
            return nil
        }
        
        
    }
}

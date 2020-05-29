//
//  AlbumExtensions.swift
//  BlueLibrarySwift
//
//  Created by Fábio Salata on 23/04/17.
//  Copyright © 2017 Raywenderlich. All rights reserved.
//

import Foundation

extension Album {
    func ae_tableRepresentation() -> (titles:[String], values:[String]) {
        return (["Artist", "Album", "Genre", "Year"], [artist, title, genre, year])
    }
}

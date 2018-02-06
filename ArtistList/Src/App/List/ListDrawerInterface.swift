//
//  ListDrawerInterface.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

protocol ListDrawerInterface {
    
    func insertArtists(artist: [ArtistCompleteEntity])
    func updateArtists(artist: ArtistCompleteEntity)
    func clear()
}

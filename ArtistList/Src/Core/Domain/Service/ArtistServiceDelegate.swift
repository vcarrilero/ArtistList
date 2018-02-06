//
//  ArtistServiceDelegate.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

protocol ArtistServiceDelegate: UpadateArtistServiceDelegate {
    
    func insertArtists(artists: [ArtistCompleteEntity]) -> Void
    func updateArtist(artist: ArtistCompleteEntity) -> Void
}

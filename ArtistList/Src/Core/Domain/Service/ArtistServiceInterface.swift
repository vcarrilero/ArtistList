//
//  ArtistServiceInterface.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

protocol ArtistServiceInterface {
    
    func getArtists(name: String) -> Void
    func setArtist (artist: ArtistCompleteEntity) -> Void
    func nextArtists () -> Void
    func getArtist (delegate: UpadateArtistServiceDelegate) -> Void
    func setDelegate (delegate: ArtistServiceDelegate) -> Void
}

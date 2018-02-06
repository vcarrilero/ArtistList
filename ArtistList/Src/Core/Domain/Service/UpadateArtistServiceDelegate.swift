//
//  UpadateArtistServiceDelegate.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

protocol UpadateArtistServiceDelegate: class {
    
    func updateArtist(artist: ArtistCompleteEntity) -> Void
    func failArtist(error: TransactionError) -> Void
}

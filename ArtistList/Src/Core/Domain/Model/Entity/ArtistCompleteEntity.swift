//
//  ArtistCompleteEntity.swift
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

enum AlbumsComplete {
    
    case waiting
    case fail
    case success(albums :[AlbumEntity])
}

struct ArtistCompleteEntity {
    
    let artist: ArtistEntity
    var albums: AlbumsComplete
}

extension ArtistCompleteEntity: Equatable {
    
    static func ==(lhs: ArtistCompleteEntity, rhs: ArtistCompleteEntity) -> Bool {
        
        return lhs.artist == rhs.artist
    }
}

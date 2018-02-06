//
//  ArtistEntity.swift
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

struct ArtistEntity {
    
    let name: String?
    let identifier: Int
    let primaryGenere: String?
}

extension ArtistEntity: Equatable {
    
    static func ==(lhs: ArtistEntity, rhs: ArtistEntity) -> Bool {
        
        return lhs.identifier == rhs.identifier
    }
}

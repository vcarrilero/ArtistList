//
//  ArtistModel.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

class ArtistModel {
    
    let repository: ArtistRepositoryInterface & NetworkRepositoryInterface
    
    init(repository: ArtistRepositoryInterface & NetworkRepositoryInterface) {
        
        self.repository = repository
    }
}

extension ArtistModel: ArtistModelInterface {
    
    func getArtist(text: String, page: Int, completion: @escaping (_ transcation: Transaction<ArtistListEntity>) -> Void ) -> Void {
        
        self.repository.getArtists(name: text, page: page, completion: completion)
    }
    
    func invalidate() -> Void {
        
        self.repository.invalidate()
    }
}


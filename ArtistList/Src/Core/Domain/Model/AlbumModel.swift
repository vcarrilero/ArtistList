//
//  AlbumModel.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

class AlbumModel {
    
    let repository: AlbumRepositoryInterface
    
    init(repository: AlbumRepositoryInterface) {
        
        self.repository = repository
    }
}

extension AlbumModel: AlbumModelInterface {
    
    func getAlbums(identifier: Int, completion: @escaping (_ transcation: Transaction<[AlbumEntity]>) -> Void ) -> Void {
        
       self.repository.getAlbum(identifier: identifier, completion: completion)
    }
}

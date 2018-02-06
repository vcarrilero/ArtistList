//
//  AlbumRepositoryInterface.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

protocol AlbumRepositoryInterface {
    
    func getAlbum(identifier: Int, completion: @escaping (_ transcation: Transaction<[AlbumEntity]>) -> Void ) -> Void
}

//
//  AlbumModelInterface.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

protocol AlbumModelInterface {
 
    func getAlbums(identifier: Int, completion: @escaping (_ transcation: Transaction<[AlbumEntity]>) -> Void ) -> Void 
}

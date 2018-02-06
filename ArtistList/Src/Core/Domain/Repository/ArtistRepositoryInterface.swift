//
//  ArtistRepositoryInterface.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

protocol ArtistRepositoryInterface {
    
    func getArtists(name: String, page: Int, completion: @escaping (_ transcation: Transaction<ArtistListEntity>) -> Void ) -> Void
}

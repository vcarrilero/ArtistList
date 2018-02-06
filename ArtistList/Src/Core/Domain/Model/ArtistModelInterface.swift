//
//  ArtistModelInterface.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

protocol ArtistModelInterface {
    
    func getArtist(text: String, page: Int, completion: @escaping (_ transcation: Transaction<ArtistListEntity>) -> Void ) -> Void
    func invalidate() -> Void
}

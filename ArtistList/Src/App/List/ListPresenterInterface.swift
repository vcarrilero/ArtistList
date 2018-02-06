//
//  ListPresenterInterface.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

protocol ListPresenterInterface: class {
    
    func search (text: String) -> Void
    func selectArtist(artist: ArtistCompleteEntity)
    func reachedEndPage () -> Void
}

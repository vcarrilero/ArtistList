//
//  SetArtistUseCase.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation


class SetArtistUseCase {
    
    let service: ArtistServiceInterface

    init(service: ArtistServiceInterface) {
        
        self.service = service
    }
    
    func execute (artist: ArtistCompleteEntity) -> Void {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            self.service.setArtist(artist: artist)
        }
    }
}

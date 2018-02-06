//
//  ArtistUseCase.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

protocol GetArtistsUseCaseDelegate: GetArtistUseCaseDelegate {
    
    func resetArtist() -> Void
    func insertArtists(artists: [ArtistCompleteEntity]) -> Void
}

class GetArtistsUseCase {
    
    weak var delegate: GetArtistsUseCaseDelegate?
    let service: ArtistServiceInterface
    
    init(service: ArtistServiceInterface) {
        
        self.service = service
    }
    
    func execute (name: String) -> Void {
        
        if let delegateUnwrapped: GetArtistsUseCaseDelegate = self.delegate {
            
            DispatchQueue.main.async {
                delegateUnwrapped.resetArtist()
            }
        }
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            self.service.getArtists(name: name)
        }
    }
    
    func next () -> Void {
        
        self.service.nextArtists()
    }
}

extension GetArtistsUseCase: ArtistServiceDelegate {
    
    func insertArtists(artists: [ArtistCompleteEntity]) -> Void {
        
        if let delegateUnwrapped: GetArtistsUseCaseDelegate = self.delegate {
         
            DispatchQueue.main.async {
                delegateUnwrapped.insertArtists(artists: artists)
            }
        }
    }
    
    func updateArtist(artist: ArtistCompleteEntity) -> Void {
        
        if let delegateUnwrapped: GetArtistsUseCaseDelegate = self.delegate {
         
            DispatchQueue.main.async {
                delegateUnwrapped.updateArtist(artist: artist)
            }
        }
    }
    
    func failArtist(error: TransactionError) -> Void {
        
        if let delegateUnwrapped: GetArtistsUseCaseDelegate = self.delegate {
     
            DispatchQueue.main.async {
                delegateUnwrapped.failArtist(error: error)
            }
        }
    }
}

//
//  GetArtistUseCase.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

protocol GetArtistUseCaseDelegate: class {
    
    func updateArtist(artist: ArtistCompleteEntity) -> Void
    func failArtist(error: TransactionError) -> Void
}

class GetArtistUseCase {
    
    weak var delegate: GetArtistUseCaseDelegate?
    let service: ArtistServiceInterface

    init(service: ArtistServiceInterface) {
        
        self.service = service
    }
    
    func execute () -> Void {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            self.service.getArtist(delegate: self)
        }
    }
}

extension GetArtistUseCase: UpadateArtistServiceDelegate {
    
    func failArtist(error: TransactionError) -> Void {
        
        if let delegateUnwrapped: GetArtistUseCaseDelegate = self.delegate {
            
            DispatchQueue.main.async {
                delegateUnwrapped.failArtist(error: error)
            }
        }
    }
    
    func updateArtist(artist: ArtistCompleteEntity) -> Void {
        
        if let delegateUnwrapped: GetArtistUseCaseDelegate = self.delegate {
            
            DispatchQueue.main.async {
                delegateUnwrapped.updateArtist(artist: artist)
            }
        }
    }
}

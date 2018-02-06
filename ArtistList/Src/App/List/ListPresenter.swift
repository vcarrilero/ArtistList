//
//  ListPresenter.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

class ListPresenter {
    
    let getArtistsUseCase: GetArtistsUseCase
    let setArtistUseCase: SetArtistUseCase
    unowned let view: ListViewInterface
    
    init(view: ListViewInterface, getArtistsUseCase: GetArtistsUseCase, setArtistUseCase: SetArtistUseCase) {
        
        self.view = view
        self.getArtistsUseCase = getArtistsUseCase
        self.setArtistUseCase = setArtistUseCase
    }
}

extension ListPresenter: ListPresenterInterface {
    
    func search (text: String) -> Void {
        
        self.getArtistsUseCase.execute(name: text)
    }
    
    func selectArtist(artist: ArtistCompleteEntity) {
        
        self.setArtistUseCase.execute(artist: artist)
        self.view.goToDetail()
    }
    
    func reachedEndPage () -> Void {
        
        self.getArtistsUseCase.next()
    }
}

extension ListPresenter: GetArtistsUseCaseDelegate {
    
    func resetArtist() -> Void {
        
        if let drawerUnwrapped: ListDrawerInterface = self.view.getDrawer {
            
            drawerUnwrapped.clear()
        }
    }
    
    func insertArtists(artists: [ArtistCompleteEntity]) -> Void {
        
        if let drawerUnwrapped: ListDrawerInterface = self.view.getDrawer {
            
            drawerUnwrapped.insertArtists(artist: artists)
        }
    }
}

extension ListPresenter: GetArtistUseCaseDelegate {
    
    func updateArtist(artist: ArtistCompleteEntity) -> Void {
        
        if let drawerUnwrapped: ListDrawerInterface = self.view.getDrawer {
            
            drawerUnwrapped.updateArtists(artist: artist)
        }
    }
    
    func failArtist(error: TransactionError) -> Void {
        
        self.view.showAlert(text: "Common_Error".localized)
    }
}

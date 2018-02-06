//
//  DetailPresenter.swift
//  ArtistList
//
//  Created by Victor on 6/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

class DetailPresenter {
    
    unowned let view: DetailViewInterface
    let usecase: GetArtistUseCase
    
    init(view: DetailViewInterface, usecase: GetArtistUseCase) {
        
        self.view = view
        self.usecase = usecase
        self.usecase.execute()
    }
}

extension DetailPresenter: DetailPresenterInterface {
    
    func selectAlbum(album: AlbumEntity) {
        
        if let url: URL = album.url {
            
            self.view.goToDetail(url: url)
        }
    }
}

extension DetailPresenter: GetArtistUseCaseDelegate {
    
    func failArtist(error: TransactionError) {
        
        self.view.showAlert(text: "Common_Error".localized)
    }
    
    func updateArtist(artist: ArtistCompleteEntity) {
        
        self.view.drawName(name: artist.artist.name)
        if case AlbumsComplete.success(let albums) = artist.albums {
            
            if let drawer: DetailDrawerInterface = self.view.getDrawer {
                
                drawer.drawAlbums(albums: albums)
            }
        }
    }
}

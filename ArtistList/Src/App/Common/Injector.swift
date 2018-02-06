//
//  Injector.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation


class Injector {
    
    static let sharedInstance: Injector = Injector()
    
    lazy var repository: AlbumRepositoryInterface & ArtistRepositoryInterface & NetworkRepositoryInterface = ApiClient()
    lazy var albumModel: AlbumModelInterface = AlbumModel(repository: self.repository)
    lazy var artistModel: ArtistModelInterface = ArtistModel(repository: self.repository)
    lazy var service: ArtistServiceInterface = ArtistService(artistModel: artistModel, albumModel: albumModel)
    
    func getList (listView: ListViewController) -> Void {
        
        let usecaseGet: GetArtistsUseCase = GetArtistsUseCase(service: self.service)
        let usecaseSet: SetArtistUseCase = SetArtistUseCase(service: self.service)
        let presenter: ListPresenterInterface & GetArtistsUseCaseDelegate  = ListPresenter(view: listView, getArtistsUseCase: usecaseGet, setArtistUseCase: usecaseSet)
        usecaseGet.delegate = presenter
        listView.presenter = presenter
        let drawer: ListDrawerInterface = ListDrawer(tableView: listView.tableView, presenter: presenter)
        listView.drawer = drawer
        self.service.setDelegate(delegate: usecaseGet)
    }
    
    func getDetail (detailView: DetailViewController) -> Void {
        
        let usecaseGet: GetArtistUseCase = GetArtistUseCase(service: self.service)
        let presenter: DetailPresenterInterface & GetArtistUseCaseDelegate  = DetailPresenter(view: detailView, usecase: usecaseGet)
        usecaseGet.delegate = presenter
        detailView.presenter = presenter
        let drawer: DetailDrawerInterface = DetailDrawer(tableView: detailView.tableView, presenter: presenter)
        detailView.drawer = drawer
    }
}

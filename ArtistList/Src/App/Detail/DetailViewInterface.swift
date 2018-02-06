//
//  DetailViewInterface.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

protocol DetailViewInterface: ViewInterface {
    
    func drawName(name: String?) -> Void
    func goToDetail (url: URL) -> Void
    var getDrawer: DetailDrawerInterface? { get }
}

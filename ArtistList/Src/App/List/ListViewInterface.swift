//
//  ListViewInterface.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

protocol ListViewInterface: ViewInterface {
    
    func goToDetail () -> Void
    var getDrawer: ListDrawerInterface? { get }
}

//
//  ViewInterface.swift
//  ArtistList
//
//  Created by Victor on 6/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

protocol ViewInterface: class {
    
    func showLoading () -> Void
    func hiddeLoading () -> Void
    func showAlert ( text: String ) -> Void
}

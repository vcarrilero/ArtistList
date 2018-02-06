//
//  Transaction.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

enum Transaction<T: Any> {
    
    case success(T)
    case fail(TransactionError)
}

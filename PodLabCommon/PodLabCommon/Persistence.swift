//
//  Persistence.swift
//  PodLabCommon
//
//  Created by Mark Schall on 1/12/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Foundation

protocol Persistence {
    func persist<T: AnyObject>( thing : T, key : String )
    func load<T>( key : String ) -> T?
}
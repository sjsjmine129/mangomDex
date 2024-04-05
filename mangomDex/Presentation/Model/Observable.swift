//
//  Observable.swift
//  mangomDex
//
//  Created by 엄승주 on 4/5/24.
//

import Foundation

class Observable<T> {

    typealias Listener = (T) -> Void
    
    var value: T? {
        didSet {
            self.listener?(value!)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
       
    private var listener: (Listener)?
    

    func bind(_ listener: @escaping Listener) {
        listener(value!)
        self.listener = listener
    }
}

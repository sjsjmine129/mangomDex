//
//  Product.swift
//  mangomDex
//
//  Created by 엄승주 on 3/3/24.
//

import Foundation

class Product {
    let name: String
    let price: Int
    var findLink: String?
    var productLink: String?
    
    init(name: String, price: Int, findLink: String, productLink:String){
        self.name = name
        self.price = price
        self.findLink = findLink
        self.productLink = productLink
    }
    
    init(name: String, price: Int, productLink:String){
        self.name = name
        self.price = price
        self.productLink = productLink
    }
    
    init(name: String, price: Int, findLink: String){
        self.name = name
        self.price = price
        self.findLink = findLink
    }
    
    init(name: String, price: Int){
        self.name = name
        self.price = price
    }
}

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
    let findLink: String
    let productLink: String
    
    init(name: String, price: Int, findLink: String, productLink:String){
        self.name = name
        self.price = price
        self.findLink = findLink
        self.productLink = productLink
    }
}

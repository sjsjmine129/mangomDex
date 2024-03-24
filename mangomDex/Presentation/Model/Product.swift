//
//  Product.swift
//  mangomDex
//
//  Created by 엄승주 on 3/3/24.
//

import Foundation

class Product {
    let productName: String
    let name: String
    let price: Int
    var findLink: String?
    var productLink: String?
    
    init(productName: String, name: String, price: Int, findLink: String, productLink:String){
        self.productName = productName
        self.name = name
        self.price = price
        self.findLink = findLink
        self.productLink = productLink
    }
    
    init(productName: String, name: String, price: Int, productLink:String){
        self.productName = productName
        self.name = name
        self.price = price
        self.productLink = productLink
    }
    
    init(productName: String, name: String, price: Int, findLink: String){
        self.productName = productName
        self.name = name
        self.price = price
        self.findLink = findLink
    }
    
    init(productName: String, name: String, price: Int){
        self.productName = productName
        self.name = name
        self.price = price
    }
}

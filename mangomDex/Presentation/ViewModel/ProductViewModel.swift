//
//  ProductViewModel.swift
//  mangomDex
//
//  Created by 엄승주 on 3/3/24.
//

import Foundation

class ProductViewModel{
    
    private(set) var products: [Product] = [
        Product(name: "망곰우유딸기샌드", price: 3600, findLink: "https://pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809895798564", productLink: "https://pocketcu.co.kr/product/detail/2023120035518?cateTyp="),
        Product(name: "망곰초코딸기샌드", price: 3600, findLink: "https://pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809895798526", productLink: "https://pocketcu.co.kr/product/detail/2024010037023?cateTyp="),
    ]
}

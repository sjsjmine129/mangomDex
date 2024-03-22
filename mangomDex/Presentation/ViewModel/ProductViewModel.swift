//
//  ProductViewModel.swift
//  mangomDex
//
//  Created by 엄승주 on 3/3/24.
//

import Foundation

class ProductViewModel{
    
    private(set) var products: [Product] = [
        Product(name: "망곰이의딸기샌드", price: 3600, findLink: "https://pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809895798564", productLink: "https://pocketcu.co.kr/product/detail/2023120035505?store_cd=&cateTyp=&chldMealEvtYn=&isNetYn=Y"),
        Product(name: "망곰초코딸기샌드", price: 3600, findLink: "https://pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809895798526", productLink: "https://pocketcu.co.kr/product/detail/2024010036989?store_cd=&cateTyp=&chldMealEvtYn=&isNetYn=Y"),
        Product(name: "망곰이초코마카롱", price: 3800, findLink: "https://www.pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809692955214", productLink: "https://www.pocketcu.co.kr/product/detail/2023110035442?store_cd=&cateTyp=&chldMealEvtYn=&isNetYn=Y"),
        Product(name: "망곰이딸기마카롱", price: 3800, findLink: "https://www.pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809692955191", productLink: "https://www.pocketcu.co.kr/product/detail/2023110035438?store_cd=&cateTyp=&chldMealEvtYn=&isNetYn=Y"),
        Product(name: "망곰이의행운버거", price: 3800, findLink: "https://www.pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809692955283", productLink: "https://www.pocketcu.co.kr/product/detail/2023120036323?store_cd=&cateTyp=&chldMealEvtYn=&isNetYn=Y"),
        Product(name: "망곰이의꿀호떡버거", price: 3400, findLink: "https://www.pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809692955115", productLink: "https://www.pocketcu.co.kr/product/detail/2023110035285?store_cd=&cateTyp=&chldMealEvtYn=&isNetYn=Y"),
        Product(name: "망곰치즈감자베이글", price: 4900, productLink: "https://www.pocketcu.co.kr/product/detail/2024010036642?store_cd=&cateTyp=&chldMealEvtYn=&isNetYn=Y"),
        Product(name: "망곰바질토마토베이글", price: 4900 ,productLink: "https://pocketcu.co.kr/product/detail/2023120035619?cateTyp=D"),

    ]
}

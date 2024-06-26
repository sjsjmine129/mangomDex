//
//  ProductViewModel.swift
//  mangomDex
//
//  Created by 엄승주 on 3/3/24.
//

import Foundation

class ProductViewModel{
    
    private(set) var products: [Product] = [
        Product(productName: "망곰이의 피크닉 샐러드", name: "망곰이의피크닉샐러드", price: 5000, findLink: "https://www.pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8801771300540"),
        Product(productName: "망곰이의 김밥세트", name: "망곰이의피크닉김밥", price: 5300, findLink: "https://www.pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809453268874"),
        Product(productName: "망곰이의 핫윙&파스타", name: "망곰이의핫윙파스타", price: 5800, findLink: "https://www.pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8801771300502"),
        Product(productName: "망곰이의 피크닉 박스", name: "망곰이의피크닉박스", price: 5900, findLink: "https://www.pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809895797611"),
        Product(productName: "망그러진 곰 우유슈크림 딸기샌드", name: "망곰이의딸기샌드", price: 3600, findLink: "https://pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809895798564", productLink: "https://pocketcu.co.kr/product/detail/2023120035505?store_cd=&cateTyp=&chldMealEvtYn=&isNetYn=Y"),
        Product(productName: "망그러진 곰 초코생딸기 페스츄리", name: "망곰초코딸기샌드", price: 3600, findLink: "https://pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809895798526", productLink: "https://pocketcu.co.kr/product/detail/2024010036989?store_cd=&cateTyp=&chldMealEvtYn=&isNetYn=Y"),
        Product(productName: "망그러진 곰 쫀득한 초코마카롱", name: "망곰이초코마카롱", price: 3800, findLink: "https://www.pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809692955214", productLink: "https://www.pocketcu.co.kr/product/detail/2023110035442?store_cd=&cateTyp=&chldMealEvtYn=&isNetYn=Y"),
        Product(productName: "망그러진 곰 쫀득한 딸기마카롱", name: "망곰이딸기마카롱", price: 3800, findLink: "https://www.pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809692955191", productLink: "https://www.pocketcu.co.kr/product/detail/2023110035438?store_cd=&cateTyp=&chldMealEvtYn=&isNetYn=Y"),
        Product(productName: "망그러진 곰 행운버거", name: "망곰이의행운버거", price: 3800, findLink: "https://www.pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809692955283", productLink: "https://www.pocketcu.co.kr/product/detail/2023120036323?store_cd=&cateTyp=&chldMealEvtYn=&isNetYn=Y"),
        Product(productName: "망그러진 곰 꿀호떡버거", name: "망곰이의꿀호떡버거", price: 3400, findLink: "https://www.pocketcu.co.kr/search/stock?isRecommend=Y&item_cd=8809692955115", productLink: "https://www.pocketcu.co.kr/product/detail/2023110035285?store_cd=&cateTyp=&chldMealEvtYn=&isNetYn=Y"),
        Product(productName: "망그러진 곰 치즈포테이토 베이글", name: "망곰치즈감자베이글", price: 4900, productLink: "https://www.pocketcu.co.kr/product/detail/2024010036642?store_cd=&cateTyp=&chldMealEvtYn=&isNetYn=Y"),
        Product(productName: "망그러진 곰 바질토마토 베이글", name: "망곰바질토마토베이글", price: 4900 ,productLink: "https://pocketcu.co.kr/product/detail/2023120035619?cateTyp=D"),
    ]
    
    
    // set Cell UI data
    func setProductCell(cell: ProoductTableViewCell, index: Int){
       let item = products[index]
        
        cell.lblProductName.text = item.productName
        cell.lblProductPrice.text = "\(item.price)원"
        cell.btnProductFind.cuApplink = item.findLink
        if item.findLink == nil {
            cell.btnProductFind.isHidden = true
        }else{
            cell.btnProductFind.isHidden = false
        }
    }
    
}

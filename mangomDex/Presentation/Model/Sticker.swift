//
//  Sticker.swift
//  mangomDex
//
//  Created by 엄승주 on 3/10/24.
//

import Foundation
import UIKit

class Sticker{
    let id: Int
    var number: Int
    let season: Int
    let name: String
    let color: UIColor
    var image: UIImage?
    var instaLink: String?
    var kakaoLink: String?
    
    
    init(id:Int, number:Int = 0){
        guard let info = StickerInfo(rawValue: id) else {
                    fatalError("Invalid sticker id")
        }
                
        self.id = id
        self.name = info.name
        self.color = info.color
        self.number = number
        self.image = UIImage(named: "\(self.id).jpg")
        
        switch id {
        case 1...20 :
            season = 1
        case 21...40:
            season = 2
        default:
            season = 0
        }
    }
    
}

enum StickerInfo: Int {
    case _01 = 1
    case _02 = 2
    case _03 = 3
    case _04 = 4
    case _05 = 5
    case _06 = 6
    case _07 = 7
    case _08 = 8
    case _09 = 9
    case _10 = 10
    case _11 = 11
    case _12 = 12
    case _13 = 13
    case _14 = 14
    case _15 = 15
    case _16 = 16
    case _17 = 17
    case _18 = 18
    case _19 = 19
    case _20 = 20
    case _21 = 21
    case _22 = 22
    case _23 = 23
    case _24 = 24
    case _25 = 25
    case _26 = 26
    case _27 = 27
    case _28 = 28
    case _29 = 29
    case _30 = 30
    case _31 = 31
    case _32 = 32
    case _33 = 33
    case _34 = 34
    case _35 = 35
    case _36 = 36
    case _37 = 37
    case _38 = 38
    case _39 = 39
    case _40 = 40
    case _41 = 41
    case _42 = 42
    case _43 = 43
    case _44 = 44
    case _45 = 45
    case _46 = 46
    case _47 = 47
    case _48 = 48
    case _49 = 49
    case _50 = 50
    case _51 = 51
    case _52 = 52
    case _53 = 53
    case _54 = 54
    case _55 = 55
    case _56 = 56
    case _57 = 57
    case _58 = 58
    case _59 = 59
    case _60 = 60
    case _61 = 61
    case _62 = 62
    case _63 = 63
    case _64 = 64
    case _65 = 65
    case _66 = 66
    case _67 = 67
    case _68 = 68
    case _69 = 69
    case _70 = 70
    case _71 = 71
    case _72 = 72
    case _73 = 73
}

extension StickerInfo{
    var name: String {
         switch self {
         case ._01:
             return "화난 눈썹 망그러진 곰"
         case ._02:
             return "체력 소진 망그러진 곰"
         case ._03:
             return "쒸익 망그러진 곰"
         case ._04:
             return "단추 팅 망그러진 곰"
         case ._05:
             return "데헷 망그러진 곰"
         case ._06:
             return "눕는게 좋아 망그러진 곰"
         case ._07:
             return "하트 꼬옥 망그러진 햄터"
         case ._08:
             return "브이 망그러진 햄터"
         case ._09:
             return "울먹 망그러진 곰"
         case ._10:
             return "안녕 망그러진 곰"
         case ._11:
             return "볼살 말랑 망그러진 곰"
         case ._12:
             return "히잉 망그러진 곰"
         case ._13:
             return "네가 좋아 망그러진 곰"
         case ._14:
             return "부끄 망그러진 곰"
         case ._15:
             return "당신을 위한 망그러진 곰"
         case ._16:
             return "헤드폰 망그러진 곰"
         case ._17:
             return "화가 망그러진 곰"
         case ._18:
             return "우비 망그러진 곰"
         case ._19:
             return "선물 망그러진 곰"
         case ._20:
             return "딸기가 좋아 망그러진 곰"
         case ._21:
             return "망그러진 감자"
         case ._22:
             return "브이 망그러진 감자"
         case ._23:
             return "부아앙 망그러진 감자"
         case ._24:
             return "둘이서 함께 망그러진 감자"
         case ._25:
             return "당신을 따르는 망그러진 감자"
         case ._26:
             return "줍줍 망그러진 감자"
         case ._27:
             return "부아앙 망그러진 곰"
         case ._28:
             return "뒹굴 망그러진 판다"
         case ._29:
             return "행복 망그러진 곰"
         case ._30:
             return "꾸벅 망그러진 곰"
         case ._31:
             return "망그러진 곰돌즈"
         case ._32:
             return "노란 수영복 망그러진 곰"
         case ._33:
             return "파란 수영복 망그러진 토끼"
         case ._34:
             return "보송 망그러진 곰"
         case ._35:
             return "빨간 한복 망그러진 곰"
         case ._36:
             return "파란 한복 망그러진 곰"
         case ._37:
             return "납작 망그러진 곰"
         case ._38:
             return "판다 망그러진 곰"
         case ._39:
             return "토끼 망그러진 곰"
         case ._40:
             return "개구리 망그러진 곰"
         case ._41:
             return "고양이 망그러진 곰"
         case ._42:
             return "곰돌이 망그러진 곰"
         case ._43:
             return "코끼리 망그러진 곰"
         case ._44:
             return "오리 망그러진 곰"
         case ._45:
             return "돼지 망그러진 곰"
         case ._46:
             return "두더지 망그러진 곰"
         case ._47:
             return "고슴도치 망그러진 곰"
         case ._48:
             return "분홍 내복 망그러진 곰"
         case ._49:
             return "엄지 척 망그러진 햄터"
         case ._50:
             return "채찍 망그러진 햄터"
         case ._51:
             return "뇸뇸 망그러진 햄터"
         case ._52:
             return "빈둥빈둥 망그러진 햄터"
         case ._53:
             return "자연스러운 포즈 망그러진 곰"
         case ._54:
             return "나비넥타이 망그러진 다람쥐"
         case ._55:
             return "댄싱 망그러진 햄터"
         case ._56:
             return "울보 산타 망그러진 곰"
         case ._57:
             return "스노우볼 망그러진 곰"
         case ._58:
             return "루돌프 망그러진 곰"
         case ._59:
             return "악마 망그러진 곰"
         case ._60:
             return "천사 망그러진 곰"
         case ._61:
             return "군고구마 망그러진 곰"
         case ._62:
             return "탐정 망그러진 곰"
         case ._63:
             return "서커스 망그러진 곰"
         case ._64:
             return "오버핏 니트 망그러진 곰"
         case ._65:
             return "하트 댄싱 망그러진 곰"
         case ._66:
             return "질투 망그러진 곰"
         case ._67:
             return "외로운 망그러진 곰"
         case ._68:
             return "쓰담쓰담 망그러진 곰"
         case ._69:
             return "행운 요정 망그러진 곰"
         case ._70:
             return "행운 만땅 망그러진 곰"
         case ._71:
             return "망그러진 행운 부적"
         case ._72:
             return "망그러진 사랑 부적"
         case ._73:
             return "망그러진 행복 부적"
         }
     }
}


extension StickerInfo{
    var color: UIColor {
        switch self {
        case ._01, ._11, ._15, ._20, ._21, ._32, ._35, ._40, ._41, ._47, ._51, ._58, ._59, ._66, ._68, ._72 :
            return .stikerOrange
        case ._02, ._04, ._17, ._22, ._24, ._28, ._37, ._42, ._44, ._54, ._60, ._62, ._69, ._71:
            return .stickerGreen
        case ._03, ._06, ._09, ._10, ._12, ._18, ._23, ._27, ._30, ._31, ._36, ._38, ._43, ._46, ._50, ._52, ._56, ._64:
            return .stickerBlue
        case ._07, ._08, ._13, ._29, ._33, ._48, ._49, ._53, ._61, ._65:
            return .stickerPink
        case ._05, ._14, ._16, ._19, ._25, ._26, ._34, ._39, ._45, ._55, ._57, ._63, ._67, ._70, ._73:
            return .stickerYellow
        }
    }
}

//extension StickerInfo{
//    var instaLink: String {
//        switch self {
//        case ._01:
//            return ""
//        case ._02:
//            return ""
//        }
//    }
//}

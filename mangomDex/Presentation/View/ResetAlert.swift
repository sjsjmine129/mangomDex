//
//  ResetAlert.swift
//  mangomDex
//
//  Created by 엄승주 on 4/5/24.
//

import Foundation
import UIKit

class ResetAlert: UIAlertController{
    required init?(coder: NSCoder) {
        let alertController = UIAlertController(title: "수집 기록 초기화", message: "수집 데이터를 초기화 하면 모든 띠부씰의 개수가 0으로 초기화됩니다!", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let proceedAction = UIAlertAction(title: "초기화", style: .default) { (action) in
            let context = self.container.viewContext
            let fetchRequest: NSFetchRequest<StickerNumbers> = StickerNumbers.fetchRequest()
            
            do {
                let stickers = try context.fetch(fetchRequest)
                for sticker in stickers {
                    sticker.number = 0
                }
                
                try context.save()
            } catch {
                print("Error updating numbers: \(error)")
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ResetStickerNumberData"), object: nil)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(proceedAction)
        
    }
}

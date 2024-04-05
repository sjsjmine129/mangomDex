//
//  CoreData.swift
//  mangomDex
//
//  Created by 엄승주 on 4/5/24.
//

import Foundation
import CoreData

class SettingData{
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func resetStickerNum(){
        let context = self.persistentContainer.viewContext
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
    }
    
}


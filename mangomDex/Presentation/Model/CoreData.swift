//
//  CoreData.swift
//  mangomDex
//
//  Created by 엄승주 on 4/5/24.
//

import Foundation
import CoreData

class CoreData_mang{
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //get StickerNumber data from coreData
    func getStickerNumber() -> [StickerNumbers]{
        let context = self.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<StickerNumbers> = StickerNumbers.fetchRequest()
        
        do {
            var coreData = try context.fetch(fetchRequest)
            
            if coreData.isEmpty {
                for id in 1...Sticker.stickeTotalNum {
                    let newData = StickerNumbers(context: context)
                    newData.id = Int16(id)
                    newData.number = 0
                    
                    do {
                        try context.save()
                    } catch {
                        print("Error saving sticker \(id): \(error)")
                    }
                }
                coreData = try context.fetch(fetchRequest)
            }

            return coreData
        } catch {
            print("Error fetching stickers: \(error)")
        }
        
        return []
    }
    
    //set StickerNum into 0
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


//
//  CoreDataManager.swift
//  HW26_KiselevBoris
//
//  Created by Борис Киселев on 19.08.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    
     init() {}
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HW26_KiselevBoris")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext
 

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func obtainUser(withName: String) -> User {
        let user = User(context: viewContext)
        user.name = withName
        user.birth = datesOfBirth.randomElement()
        user.gender = "male"
        user.image = imagesData.randomElement() as? Data
        
        do {
            try? viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        self.saveContext()
        
        do {
            try viewContext.save()
        } catch let error {
            print("Error \(error)")
        }
        print(self.persistentContainer.accessibilityElementCount())
        return user
    }
    
    func fetchUsers() -> [NSManagedObject] {

        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let objects = try! viewContext.fetch(fetchRequest)
        return objects
    }
}

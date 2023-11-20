//
//  Presenter.swift
//  HW26_KiselevBoris
//
//  Created by Борис Киселев on 17.08.2022.
//

import Foundation
import CoreData

class Presenter {
    let dataManager = CoreDataManager()
    
    func fetchedUsers() -> [NSManagedObject] {
        let storage = dataManager.fetchUsers()
        return storage
    }
    
    func saveContext() {
        dataManager.saveContext()
    }
  
    func obtainUser(with name: String) -> User {
        dataManager.obtainUser(withName: name)
    }
    
    func deleteUser(user: User) {
        dataManager.viewContext.delete(user)
    }
}



    
    


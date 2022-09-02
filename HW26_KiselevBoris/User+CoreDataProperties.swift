//
//  User+CoreDataProperties.swift
//  HW26_KiselevBoris
//
//  Created by Борис Киселев on 19.08.2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var birth: String?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?
    @NSManaged public var image: Data?

}

extension User : Identifiable {

}

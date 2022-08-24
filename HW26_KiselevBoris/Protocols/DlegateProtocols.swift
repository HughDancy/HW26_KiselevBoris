//
//  DlegateProtocols.swift
//  HW26_KiselevBoris
//
//  Created by Борис Киселев on 17.08.2022.
//

import Foundation
import CoreData

protocol ViewImputDelegate: AnyObject {
    func setupData(with testData: ([Citizen]))
    func displayData(i: Int)
}

protocol ViewOutputDelegate: AnyObject {
    func getData()
    func saveData()
}

protocol UpdateUsers: AnyObject {
    func update(with: [NSManagedObject])
}

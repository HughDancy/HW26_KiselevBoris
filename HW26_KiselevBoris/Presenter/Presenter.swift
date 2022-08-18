//
//  Presenter.swift
//  HW26_KiselevBoris
//
//  Created by Борис Киселев on 17.08.2022.
//

import Foundation
import UIKit

class Presenter {
    
    weak private var viewInputDelegate: ViewImputDelegate?
    var testData = Citizen.citizen
    
    func setViewImputDelegate(viewInputDelegate: ViewImputDelegate?) {
        self.viewInputDelegate = viewInputDelegate
    }
    
    private func loadTestData() {
        self.viewInputDelegate?.setupData(with: testData)
        self.viewInputDelegate?.displayData(i: 0)
    }
    
     func updateCell(index: Int) {
        user.removeAll()
        user.append(testData[index].name)
        user.append(testData[index].birth)
        user.append(testData[index].gender)
         userImage = testData[index].image ?? rayan!
    }
    
}


extension Presenter: ViewOutputDelegate {
    func getData() {
        loadTestData()
    }
    
    func saveData() {
        print("0")
    }
    
    
}

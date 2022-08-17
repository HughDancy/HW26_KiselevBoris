//
//  Presenter.swift
//  HW26_KiselevBoris
//
//  Created by Борис Киселев on 17.08.2022.
//

import Foundation

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
}


extension Presenter: ViewOutputDelegate {
    func getData() {
        loadTestData()
    }
    
    func saveData() {
        print("0")
    }
    
    
}

//
//  Model.swift
//  HW26_KiselevBoris
//
//  Created by Борис Киселев on 17.08.2022.
//

import Foundation
import UIKit

struct Citizen {
    var name: String
    var birth: String
    var gender: String
    //    var image: UIImage
}

extension Citizen {
    static var citizen = [
        Citizen(name: "Ivan Ivanovich", birth: "24.04.1987", gender: "male"),
        Citizen(name: "Petr Petrovich", birth: "17.02.2000", gender: "male"),
        Citizen(name: "Stepa Stepanovich", birth: "08.01.1979", gender: "male")
    ]
}

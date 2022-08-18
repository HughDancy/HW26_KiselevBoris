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
    var image: UIImage?
}

let rayan = UIImage(named: "Man")
let nathan = UIImage(named: "Nathan")
let sekiro = UIImage(named: "Sekiro")
let sam = UIImage(named: "Sam")

extension Citizen {
    static var citizen = [
        Citizen(name: "Rayan Gosling", birth: "12.11.1980", gender: "male", image: rayan),
        Citizen(name: "Nathan Drake", birth: "17.02.1976", gender: "male", image: nathan),
        Citizen(name: "Sekiro", birth: "08.01.1469", gender: "male", image: sekiro),
        Citizen(name: "Sam Bridges", birth: "09.11.2087", gender: "male", image: sam)
    ]
}

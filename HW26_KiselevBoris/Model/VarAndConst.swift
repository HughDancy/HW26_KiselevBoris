//
//  VarAndConst.swift
//  HW26_KiselevBoris
//
//  Created by Борис Киселев on 18.08.2022.
//

import Foundation
import UIKit
import CoreData

var myIndex: Int = 0
//var user = [String]()
//var userImage = UIImage()
let icons = [UIImage(named: "userIcon"), UIImage(named: "birthIcon"), UIImage(named: "genderIcon")]

var data = Data()

let rayanData = rayan?.jpegData(compressionQuality: 1.0)
let nathanData = nathan?.jpegData(compressionQuality: 1.0)
let samData = sam?.jpegData(compressionQuality: 1.0)
let sekiroData = sekiro?.jpegData(compressionQuality: 1.0)

let datesOfBirth = ["18.03.1976", "02.05.1966", "09.09.1990", "10.10.2000", "25.11.1993", "30.06.1992", "03.03.1987", "20.04.1985", "22.11.2002", "01.01.1991", "29.08.1996", "14.02.1989", "23.07.1972",]
let imagesData = [rayanData, nathanData, samData, sekiroData]

//let manager = CoreDataManager()
//let fisrtUser = manager.obtainUser(withName: "Rayan Gosling")
//let secondUser = manager.obtainUser(withName: "Stranger Thing")
//let thirdUser = manager.obtainUser(withName: "Motherfucker")

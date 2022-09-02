//
//  VarAndConst.swift
//  HW26_KiselevBoris
//
//  Created by Борис Киселев on 18.08.2022.
//

import Foundation
import UIKit
import CoreData

// MARK: Assistance var

var myIndex: Int = 0


// MARK: - Images and massives of images

var data = Data()

let icons = [UIImage(named: "userIcon"), UIImage(named: "birthIcon"), UIImage(named: "genderIcon")]

let rayan = UIImage(named: "Man")
let nathan = UIImage(named: "Nathan")
let sekiro = UIImage(named: "Sekiro")
let sam = UIImage(named: "Sam")
let kratos = UIImage(named: "Kratos")
let joel = UIImage(named: "Joel")
let deacon = UIImage(named: "Deacon")
let geralt = UIImage(named: "Geralt")
let doomslayer = UIImage(named: "Doomslayer")

let rayanData = rayan?.jpegData(compressionQuality: 1.0)
let nathanData = nathan?.jpegData(compressionQuality: 1.0)
let samData = sam?.jpegData(compressionQuality: 1.0)
let sekiroData = sekiro?.jpegData(compressionQuality: 1.0)
let kratosData = kratos?.jpegData(compressionQuality: 1.0)
let joelData = joel?.jpegData(compressionQuality: 1.0)
let deaconData = deacon?.jpegData(compressionQuality: 1.0)
let geraltData = geralt?.jpegData(compressionQuality: 1.0)
let doomslayerData = doomslayer?.jpegData(compressionQuality: 1.0)

let datesOfBirth = ["18.03.1976", "02.05.1966", "09.09.1990", "10.10.2000", "25.11.1993", "30.06.1992", "03.03.1987", "20.04.1985", "22.11.2002", "01.01.1991", "29.08.1996", "14.02.1989", "23.07.1972",]
let imagesData = [rayanData, nathanData, samData, sekiroData, kratosData, joelData, deaconData, geraltData, doomslayerData]

// MARK: - Assistance function

func iconCreate(with image: String) -> UIImageView {
    let imageView = UIImageView()
    let image = UIImage(named: image)
    imageView.image = image
    
    return imageView
}

func labelCreate() -> UILabel {
    let label = UILabel()
    label.font = UIFont(name: "Noto Sans Kannada", size: 20)
    return label
}

func createTextField() -> UITextField {
    let textField = UITextField()
    textField.font = UIFont(name: "Noto Sans Kannada", size: 20)
    textField.isHidden = true
    
    return textField
}

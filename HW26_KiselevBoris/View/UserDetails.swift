//
//  UserDetails.swift
//  HW26_KiselevBoris
//
//  Created by Борис Киселев on 17.08.2022.
//

import UIKit
import CoreData

class UserDetails: UIViewController {
    
    private let presenter = Presenter()
    weak private var viewOutputDelegate: ViewOutputDelegate?
    let manager = CoreDataManager()
    var content = [NSManagedObject]()
    
    // MARK: - SubView's
    let userCIntroller = ViewController()
    
    let image = UIImage(named: "Man")
    
    var editButton: UIButton = {
        var editButton = UIButton()
        editButton.tintColor = .systemCyan
        editButton.addTarget(self, action: #selector(tapEditButton), for: .touchDown)
        
        return editButton
    }()
    
    var saveButton: UIButton = {
        var saveButton = UIButton()
        saveButton.tintColor = .systemGreen
        saveButton.isHidden = true
        saveButton.addTarget(self, action: #selector(tapSaveButton), for: .touchDown)
        
        return saveButton
    }()
    
    var imageProfile: UIImageView = {
        var imageProfile = UIImageView()
        imageProfile.contentMode = .scaleAspectFill
        let image = UIImage(named: "Man")
        imageProfile.image = image
        

        return imageProfile
    }()
    
    var userIcon: UIImageView = {
        var userIcon = UIImageView()
        let image = UIImage(named: "userIcon")
        userIcon.image = image
        
        return userIcon
    }()
    
    var birthIcon: UIImageView = {
        var birthIcon = UIImageView()
        let image = UIImage(named: "birthIcon")
        birthIcon.image = image
        
        return birthIcon
    }()
    
    var genderICon: UIImageView = {
        var genderIcon = UIImageView()
        let image = UIImage(named: "genderIcon")
        genderIcon.image = image
        
        return genderIcon
    }()
    
    var userNameLabel: UILabel = {
        var userNameLabel = UILabel()
        userNameLabel.font = UIFont(name: "Hoefler Text", size: 20)
        
        return userNameLabel
    }()
    
    var birthLabel: UILabel = {
        var birthLabel = UILabel()
        birthLabel.font = UIFont(name: "Hoefler Text", size: 20)
        
        return birthLabel
    }()
    
    var genderLabel: UILabel = {
        var genderLabel = UILabel()
        genderLabel.font = UIFont(name: "Hoefler Text", size: 20)
        
        return genderLabel
    }()
    
    var userNameTextField: UITextField =  {
        var userNameTextField = UITextField()
        userNameTextField.font = UIFont(name: "Hoefler Text", size: 20)
        userNameTextField.isHidden = true
        
        return userNameTextField
    }()
    
    var birthTextField: UITextField = {
        var birthTextField = UITextField()
        birthTextField.font = UIFont(name: "Hoefler Text", size: 20)
        birthTextField.isHidden = true
        
        return birthTextField
    }()
    
    var genderTextField: UITextField = {
        var genderTextField = UITextField()
        genderTextField.font = UIFont(name: "Hoefler Text", size: 20)
        genderTextField.isHidden = true
        
        return genderTextField
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        content = manager.fetchUsers()
        addingSbuviews()
        imageProfile.center = view.center
        buttonsSetup()
        adeddContent()
        setupLayout()
        
    }
    
    // MARK: - Settings
    
    private func addingSbuviews() {
        view.addSubview(editButton)
        view.addSubview(saveButton)
        view.addSubview(imageProfile)
        view.addSubview(userIcon)
        view.addSubview(birthIcon)
        view.addSubview(genderICon)
        view.addSubview(userNameLabel)
        view.addSubview(birthLabel)
        view.addSubview(genderLabel)
        view.addSubview(userNameTextField)
        view.addSubview(birthTextField)
        view.addSubview(genderTextField)
        
        view.backgroundColor = .white
        
    }
    
    private func buttonsSetup() {
        editButton.configuration = .filled()
        editButton.configuration?.title = "Edit"
        
        saveButton.configuration = .filled()
        saveButton.configuration?.title = "Save"
    }
    
    
    private func adeddContent() {
        //        let content = manager.fetchUsers()
        userNameLabel.text = content[myIndex].value(forKey: "name") as? String
        imageProfile.image = UIImage(data: content[myIndex].value(forKey: "image") as? Data ?? data)
        birthLabel.text = content[myIndex].value(forKey: "birth") as? String
        genderLabel.text = content[myIndex].value(forKey: "gender") as? String
        
        userNameTextField.placeholder = content[myIndex].value(forKey: "name") as? String
        birthTextField.placeholder = content[myIndex].value(forKey: "birth") as? String
        genderTextField.placeholder = content[myIndex].value(forKey: "gender") as? String
    }
    
    // MARK: - Button's Action
    
    @objc private func tapEditButton() {
        editButton.isHidden = true
        userNameLabel.isHidden = true
        birthLabel.isHidden = true
        genderLabel.isHidden = true
        
        saveButton.isHidden = false
        userNameTextField.isHidden = false
        birthTextField.isHidden = false
        genderTextField.isHidden = false
    }
    
    @objc private func tapSaveButton() {
        saveButton.isHidden = true
        userNameTextField.isHidden = true
        birthTextField.isHidden = true
        genderTextField.isHidden = true
        
        if  userNameTextField.text != "" {
            content[myIndex].setValue(userNameTextField.text, forKey: "name")
            manager.saveContext()
            userNameLabel.text = content[myIndex].value(forKey: "name") as? String
        }
        
        if birthTextField.text != "" {
            content[myIndex].setValue(birthTextField.text, forKey: "birth")
            manager.saveContext()
            birthLabel.text = content[myIndex].value(forKey: "birth") as? String
        }
        
        if genderTextField.text != "" {
            content[myIndex].setValue(genderTextField.text, forKey: "gender")
            manager.saveContext()
            genderLabel.text = content[myIndex].value(forKey: "gender") as? String
        }
        
        userCIntroller.pepolesTable.reloadData()
         
        editButton.isHidden = false
        userNameLabel.isHidden = false
        birthLabel.isHidden = false
        genderLabel.isHidden = false
    }
    
    
    // MARK: - Setup Layout
    
    private func setupLayout() {
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        editButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        imageProfile.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        imageProfile.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageProfile.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageProfile.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageProfile.layer.cornerRadius = 200 / 2
        imageProfile.clipsToBounds = true
        
        userIcon.translatesAutoresizingMaskIntoConstraints = false
        userIcon.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 40).isActive = true
        userIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        
        birthIcon.translatesAutoresizingMaskIntoConstraints = false
        birthIcon.topAnchor.constraint(equalTo: userIcon.bottomAnchor, constant: 27).isActive = true
        birthIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        
        genderICon.translatesAutoresizingMaskIntoConstraints = false
        genderICon.topAnchor.constraint(equalTo: birthIcon.bottomAnchor, constant: 27).isActive = true
        genderICon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 45).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: userIcon.trailingAnchor, constant: 20).isActive = true
        
        birthLabel.translatesAutoresizingMaskIntoConstraints = false
        birthLabel.topAnchor.constraint(equalTo: userIcon.bottomAnchor, constant: 30).isActive = true
        birthLabel.leadingAnchor.constraint(equalTo: birthIcon.trailingAnchor, constant: 18).isActive = true
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.topAnchor.constraint(equalTo: birthIcon.bottomAnchor, constant: 30).isActive = true
        genderLabel.leadingAnchor.constraint(equalTo: genderICon.trailingAnchor, constant: 20).isActive = true
        
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 45).isActive = true
        userNameTextField.leadingAnchor.constraint(equalTo: userIcon.trailingAnchor, constant: 20).isActive = true
        
        birthTextField.translatesAutoresizingMaskIntoConstraints = false
        birthTextField.topAnchor.constraint(equalTo: userIcon.bottomAnchor, constant: 30).isActive = true
        birthTextField.leadingAnchor.constraint(equalTo: birthIcon.trailingAnchor, constant: 18).isActive = true
        
        genderTextField.translatesAutoresizingMaskIntoConstraints = false
        genderTextField.topAnchor.constraint(equalTo: birthIcon.bottomAnchor, constant: 30).isActive = true
        genderTextField.leadingAnchor.constraint(equalTo: genderICon.trailingAnchor, constant: 20).isActive = true
    }
    
}








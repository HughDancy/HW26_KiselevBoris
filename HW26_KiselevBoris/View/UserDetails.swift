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
    let manager = CoreDataManager()
    var content = [NSManagedObject]()
    var user: NSManagedObject?
    
    
    // MARK: - SubView's

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

        return imageProfile
    }()
    
    var userIcon: UIImageView = {
        return iconCreate(with: "userIcon")
    }()
    
    var birthIcon: UIImageView = {
        return iconCreate(with: "birthIcon")
    }()
    
    var genderICon: UIImageView = {
        return iconCreate(with: "genderIcon")
    }()
    
    var userNameLabel: UILabel = {
        return labelCreate()
    }()
    
    var birthLabel: UILabel = {
        return labelCreate()
    }()
    
    var genderLabel: UILabel = {
        return labelCreate()
    }()
    
    var userNameTextField: UITextField =  {
        return createTextField()
    }()
    
    var birthTextField: UITextField = {
        return createTextField()
    }()
    
    var genderTextField: UITextField = {
        return createTextField()
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        content = manager.fetchUsers()
        content = presenter.fetchedUsers()
        setupHierarchy()
        imageProfile.center = view.center
        buttonsSetup()
        adeddContent()
        setupLayout()
        view.backgroundColor = .white
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
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
    }
    
    private func buttonsSetup() {
        editButton.configuration = .filled()
        editButton.configuration?.title = "Edit"
        
        saveButton.configuration = .filled()
        saveButton.configuration?.title = "Save"
    }
    
    private func adeddContent() {
        
        userNameLabel.text = user?.value(forKey: "name") as? String
        imageProfile.image = UIImage(data: user?.value(forKey: "image") as? Data ?? data)
        birthLabel.text = user?.value(forKey: "birth") as? String
        genderLabel.text = user?.value(forKey: "gender") as? String
        
        userNameTextField.placeholder = user?.value(forKey: "name") as? String
        birthTextField.placeholder = user?.value(forKey: "birth") as? String
        genderTextField.placeholder = user?.value(forKey: "gender") as? String
    }
    
    // MARK: - Button's Action
    
    @objc private func tapEditButton() {
        activateEdit()
    }
    
    @objc private func tapSaveButton() {
        activateSave()
        
        if  userNameTextField.text != "" {
            user?.setValue(userNameTextField.text, forKey: "name")
            content[myIndex].setValue(userNameTextField.text, forKey: "name")
            userNameLabel.text = user?.value(forKey: "name") as? String
            presenter.saveContext()
        }
        
        if birthTextField.text != "" {
            user?.setValue(birthTextField.text, forKey: "birth")
            content[myIndex].setValue(birthTextField.text, forKey: "birth")
            birthLabel.text = user?.value(forKey: "birth") as? String
            presenter.saveContext()
        }
        
        if genderTextField.text != "" {
            user?.setValue(genderTextField.text, forKey: "gender")
            content[myIndex].setValue(genderTextField.text, forKey: "gender")
            genderLabel.text = user?.value(forKey: "gender") as? String
            presenter.saveContext()
        }
    }
    
    func activateEdit() {
        editButton.isHidden = true
        userNameLabel.isHidden = true
        birthLabel.isHidden = true
        genderLabel.isHidden = true
        
        
        saveButton.isHidden = false
        userNameTextField.isHidden = false
        birthTextField.isHidden = false
        genderTextField.isHidden = false
    }
    
    func activateSave() {
        saveButton.isHidden = true
        userNameTextField.isHidden = true
        birthTextField.isHidden = true
        genderTextField.isHidden = true
        
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








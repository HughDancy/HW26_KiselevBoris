//
//  UserDetails.swift
//  HW26_KiselevBoris
//
//  Created by Борис Киселев on 17.08.2022.
//

import UIKit

class UserDetails: UIViewController {
  
    private let presenter = Presenter()
    weak private var viewOutputDelegate: ViewOutputDelegate?
    
    // MARK: - SubView's
    
    let image = UIImage(named: "Man")
    
    var editButton: UIButton = {
        var editButton = UIButton()
        editButton.addTarget(self, action: #selector(tapEditButton), for: .touchDown)
        
        return editButton
    }()
    
    var saveButton: UIButton = {
        var saveButton = UIButton()
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
    
    var userInfoTable = UITableView(frame: .zero, style: UITableView.Style.plain)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingSbuviews()
        imageProfile.center = view.center
        buttonsSetup()
        tableSettings()
        setupLayout()
        
    
    }
    
    // MARK: - Settings
    
    private func addingSbuviews() {
        view.addSubview(editButton)
        view.addSubview(saveButton)
        view.addSubview(imageProfile)
        view.addSubview(userInfoTable)
        
        view.backgroundColor = .white
        
    }
    
    private func buttonsSetup() {
        editButton.configuration = .filled()
        editButton.configuration?.title = "Edit"
        
        saveButton.configuration = .filled()
        saveButton.configuration?.title = "Save"
    }
    
    private func tableSettings() {
        userInfoTable.delegate = self
        userInfoTable.dataSource = self
        userInfoTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: - Button's Action
    
    @objc private func tapEditButton() {
        editButton.isHidden = true
        saveButton.isHidden = false
    }
    
    @objc private func tapSaveButton() {
        saveButton.isHidden = true
        editButton.isHidden = false
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
        
        userInfoTable.translatesAutoresizingMaskIntoConstraints = false
        userInfoTable.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 40).isActive = true
        userInfoTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        userInfoTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -10).isActive = true
        userInfoTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        
    }
    
}

// MARK: - ViewController Extension

extension UserDetails: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var cellContent = cell.defaultContentConfiguration()
        cellContent.text = user[indexPath.row]
        cellContent.image = icons[indexPath.row]
        imageProfile.image = userImage
        
        cell.contentConfiguration = cellContent
        return cell
    }
    
    
}

 



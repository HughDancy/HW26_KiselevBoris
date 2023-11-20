//
//  ViewController.swift
//  HW26_KiselevBoris
//
//  Created by Борис Киселев on 17.08.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    //MARK: - Delegate and Presenter
    
    private let presenter = Presenter()
    var manager = CoreDataManager()
    var users = [NSManagedObject]()

    // MARK: - View's
    
    private lazy var textField: UITextField = {
        var textField = UITextField()
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var button: UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(addNewUser), for: .touchDown)
        
        return button
    }()
    
    lazy var peopolesTable: UITableView = {
        var peoplesTable = UITableView(frame: .zero, style: UITableView.Style.insetGrouped)
        peoplesTable.delegate = self
        peoplesTable.dataSource = self
        peoplesTable.backgroundColor = .clear
        peoplesTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return peoplesTable
    }()
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        peopolesTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopolesTable.reloadData()
        users = presenter.fetchedUsers()
        
        view.backgroundColor = UIColor(displayP3Red: 0.96, green: 0.96, blue: 0.98, alpha: 1)
        title = "Users"
        
        addSubviews()
        buttonSetup()
        setupLayout()
    }
    
    // MARK: - Settings
    
    private func buttonSetup() {
        button.configuration = .filled()
        button.configuration?.title = "Добавить"
    }
    
    private func addSubviews() {
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(peopolesTable)
    }
    
    // MARK: - Button Action
    
    @objc func addNewUser() {
        guard textField.text != "" else { return }
        let newUser = presenter.obtainUser(with: textField.text ?? "")
        users.append(newUser)
        presenter.saveContext()
        peopolesTable.reloadData()
        textField.text = nil
    }
    
    // MARK: - Setup layout
    
    private func setupLayout() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        peopolesTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            peopolesTable.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 25),
            peopolesTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            peopolesTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            peopolesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - ViewController Extension

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = users[indexPath.row].value(forKey: "name") as? String
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = tableView.indexPathForSelectedRow?.row ?? 0
        let userInfo = UserDetails()
        userInfo.user = users[indexPath.row]
        navigationController?.pushViewController(userInfo, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let user = users[indexPath.row] as! User
        presenter.deleteUser(user: user)
        users.remove(at: indexPath.row)
        presenter.saveContext()
        tableView.deleteRows(at: [indexPath], with: .top)
        tableView.reloadData()
    }
}




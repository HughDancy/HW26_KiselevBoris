//
//  ViewController.swift
//  HW26_KiselevBoris
//
//  Created by Борис Киселев on 17.08.2022.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Delegate and Presenter
    
    private var testData: [Citizen] = []
    private let presenter = Presenter()
    weak private var viewOutputDelegate: ViewOutputDelegate?
    
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
    private lazy var pepolesTable = UITableView(frame: .zero, style: UITableView.Style.insetGrouped)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewImputDelegate(viewInputDelegate: self)
        self.viewOutputDelegate = presenter
        self.viewOutputDelegate?.getData()
        
        view.backgroundColor = UIColor(displayP3Red: 0.96, green: 0.96, blue: 0.98, alpha: 1)
        title = "Users"
        
        addSubviews()
        buttonSetup()
        setupLayout()
        tableSettings()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Settings
    
    private func buttonSetup() {
        button.configuration = .filled()
        button.configuration?.title = "Добавить"
    }
    
    private func addSubviews() {
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(pepolesTable)
    }
    
    private func tableSettings() {
        pepolesTable.delegate = self
        pepolesTable.dataSource = self
        pepolesTable.backgroundColor = .clear
        pepolesTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: - Button Action
    
    @objc func addNewUser() {
        let newImage = UIImage(named: "Man")
        let newUser = Citizen(name: textField.text ?? "", birth: "bugaga", gender: "bugaga", image: newImage)
        presenter.testData.append(newUser)
        pepolesTable.reloadData()
        print(presenter.testData)
    }
    
    // MARK: - Setup layout
    
    private func setupLayout() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        pepolesTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            pepolesTable.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 25),
            pepolesTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            pepolesTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            pepolesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - ViewController Extension

extension ViewController: ViewImputDelegate {
    func setupData(with testData: ([Citizen])) {
        self.testData = testData
        
    }
    
    func displayData(i: Int) {
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.testData.count
//        return testData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = presenter.testData[indexPath.row].name
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = tableView.indexPathForSelectedRow?.row ?? 0
        presenter.updateCell(index: myIndex)
        let userInfo = UserDetails()
        navigationController?.pushViewController(userInfo, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        presenter.testData.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .top)
        tableView.reloadData()
    }
}


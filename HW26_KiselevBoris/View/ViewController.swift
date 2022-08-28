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
    
    var manager = CoreDataManager()
    var users = [NSManagedObject]()
    
    private var testData: [Citizen] = []
    private let presenter = Presenter()
    weak private var viewOutputDelegate: ViewOutputDelegate?
//    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//
//        return fetchResultController
//
//    }()
//    let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
//    let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//    let managedContext = NSManagedObjectContext(.mainQueue)
   

    
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
    
    lazy var pepolesTable: UITableView = {
        var peoplesTable = UITableView(frame: .zero, style: UITableView.Style.insetGrouped)
        peoplesTable.delegate = self
        peoplesTable.dataSource = self
        peoplesTable.backgroundColor = .clear
        peoplesTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return peoplesTable
    }()
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        pepolesTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewImputDelegate(viewInputDelegate: self)
        self.viewOutputDelegate = presenter
        self.viewOutputDelegate?.getData()
        pepolesTable.reloadData()
//        managedContext.refreshAllObjects()
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        fetchResultCntl = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//        fetchResultController.delegate = self
//        try! fetchResultController.performFetch()

        
        view.backgroundColor = UIColor(displayP3Red: 0.96, green: 0.96, blue: 0.98, alpha: 1)
        title = "Users"
       updateData()
        users = manager.fetchUsers()
        
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
        view.addSubview(pepolesTable)
    }
    
    func updateData() {
        if manager.persistentContainer.viewContext.hasChanges {
            print("Context has changed")
        }
    }
    
    func adeddSortDescriptor() {
        
    }
   
    // MARK: - Button Action
    
    @objc func addNewUser() {
        guard textField.text != "" else { return }
        let newUser = manager.obtainUser(withName: textField.text ?? "")
        users.append(newUser)
        manager.saveContext()
        pepolesTable.reloadData()
        textField.text = nil
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
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let persons = manager.fetchUsers()
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
        
        manager.viewContext.delete(users[indexPath.row])
        users.remove(at: indexPath.row)
        manager.saveContext()
        tableView.deleteRows(at: [indexPath], with: .top)
        tableView.reloadData()
    }
}

//extension ViewController: NSFetchedResultsControllerDelegate {
//
//
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        pepolesTable.beginUpdates()
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .update:
//            if let indexPath = indexPath {
//                let user = fetchResultController.object(at: indexPath) as! User
//                let cell = pepolesTable.cellForRow(at: indexPath)
//                var content = cell?.defaultContentConfiguration()
//                content?.text = user.name
//                cell?.contentConfiguration = content
//                print("aloha")
//            }
//
//        default:
//            break
//        }
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        pepolesTable.endUpdates()
//        pepolesTable.reloadData()
//    }
//}
//


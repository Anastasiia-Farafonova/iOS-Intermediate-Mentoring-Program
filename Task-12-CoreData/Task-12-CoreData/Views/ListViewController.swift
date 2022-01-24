//
//  ViewController.swift
//  Task-12-CoreData
//
//  Created by Anastasiia Farafonova on 24.01.2022.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    private enum Const {
        static let cellIdentifier = "cellIdentifier"
        static let cellNibName = "PersonCell"
        static let creationViewControllerId = "CreationViewController"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    private let viewModel = ViewModel()
    private lazy var fetchedResultsController: NSFetchedResultsController<Person> = {
        return viewModel.getFetchResultsController()
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "The List"
        tableView.register(UINib.init(nibName: Const.cellNibName, bundle: nil), forCellReuseIdentifier: Const.cellIdentifier)
        fetchedResultsController.delegate = self
    }
    
    @IBAction private func openCreation(_ sender: UIBarButtonItem) {
        let newView = storyboard?.instantiateViewController(withIdentifier: Const.creationViewControllerId) as! CreationViewController
        newView.viewModel = viewModel
        navigationController?.pushViewController(newView, animated: true)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = fetchedResultsController.object(at: indexPath)
            tableView.beginUpdates()
            viewModel.delete(person: person)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedResultsController.sections?[section] else { return 0 }
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellIdentifier,
                                                       for: indexPath) as? PersonCell else { return UITableViewCell() }
        
        let person = fetchedResultsController.object(at: indexPath)
        
        cell.setup(name: person.name,
                   email: person.email,
                   phone: person.phone,
                   address: person.address,
                   image: UIImage(contentsOfFile: person.photoUrl?.path ?? ""))
        
        return cell
    }
}

extension ListViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            return
        }
    }
}

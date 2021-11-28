//
//  FolderTableViewController.swift
//  Notes
//
//

import UIKit
import CoreData

class FolderListViewController: UITableViewController {
    
    @IBOutlet weak var createFolderButton: UIBarButtonItem!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    var viewModel: FolderListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createFolderButton.accessibilityIdentifier = "create_folder"
        tableView.accessibilityIdentifier = "folders_list"
        setupTableView()
        createSortMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.dataSource.delegate = self
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.dataSource.delegate = nil
    }
    
    @IBAction private func addFolderButtonAction(_ sender: UIBarButtonItem) {
        present(createAlertController(), animated: true)
    }
    
    private func createAlertController() -> UIAlertController {
        let alert = UIAlertController(title: "New Folder",
                                      message: "Enter a name for this folder.",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
            guard let textField = alert.textFields?.first,
                  let nameToSave = textField.text,
                  let self = self else { return }
            self.viewModel.createFolder(name: nameToSave)
            self.tableView.reloadData()
        }
        
        saveAction.accessibilityIdentifier = "save_folder"
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { textField in
            textField.accessibilityIdentifier = "folder_name_textfield"
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        return alert
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FolderViewCell = dequeueCell(indexPath: indexPath)
        
        if let folder = viewModel.dataSource.object(at: indexPath) {
            cell.setupViews(folder: folder)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, let folder = viewModel.dataSource.object(at: indexPath) {
            viewModel.delete(folder: folder)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.numberOfObjectIn(section: section)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let folder = viewModel.dataSource.object(at: indexPath) {
            viewModel.showNotesList(folder: folder)
        }
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: FolderViewCell.nibName(), bundle: nil),
                           forCellReuseIdentifier: FolderViewCell.nibName())
    }
    
    private func createSortMenu() {
        sortButton.menu = createSortMenu(sortByName: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.sort(by: .name)
            self.tableView.reloadData()
        }, sortByDate: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.sort(by: .creationDate)
            self.tableView.reloadData()
        })
    }
}

extension FolderListViewController: FolderDataSourceDelegate {
    func dataSourceWillChangeContent(_ dataSource: FolderDataSourceProtocol) {
        tableView.beginUpdates()

    }
    
    func dataSourceDidChangeContent(_ dataSource: FolderDataSourceProtocol) {
        tableView.endUpdates()

    }
    
    func dataSource(_ dataSource: FolderDataSourceProtocol,
                    didChange folder: FolderProtocol,
                    at indexPath: IndexPath?,
                    for type: DataSourceChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .left)
            }
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                tableView.moveRow(at: indexPath, to: newIndexPath)
            }
        case .update:
            if let indexPath = indexPath,
               let cell = tableView.cellForRow(at: indexPath) as? FolderViewCell {
                cell.setupViews(folder: folder)
            }
        }
    }
}

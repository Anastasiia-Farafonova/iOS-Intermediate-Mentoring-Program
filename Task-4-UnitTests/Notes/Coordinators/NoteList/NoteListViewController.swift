//
//  NoteListViewController.swift
//  Notes
//
//

import UIKit
import CoreData

class NoteListViewController: UITableViewController {
    var viewModel: NoteListViewModel!
    
    @IBOutlet weak var sortButton: UIBarButtonItem!
    @IBOutlet weak var notesCountLabel: UIBarButtonItem!
    @IBOutlet weak var createNoteButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.dataSource.delegate = self
        tableView.accessibilityIdentifier = "notes_list"
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: NoteViewCell.nibName(), bundle: nil),
                           forCellReuseIdentifier: NoteViewCell.nibName())
        
        createNoteButton.accessibilityIdentifier = "create_note"
        createSortMenu()
        updateToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setToolbarHidden(false, animated: true)
    }

    @IBAction func addNoteButtonAction(_ sender: UIBarButtonItem) {
        viewModel.addNoteTapped()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NoteViewCell = dequeueCell(indexPath: indexPath)
        
        cell.setupView(note: viewModel.dataSource.object(at: indexPath))
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.numberOfObjectIn(section: section)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.tappedNote(note: viewModel.dataSource.object(at: indexPath))
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(note: viewModel.dataSource.object(at: indexPath))
        }
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
    
    private func updateToolBar() {
        notesCountLabel.title = "\(viewModel.dataSource.numberOfObjectIn(section: 0)) notes"
    }
}

extension NoteListViewController: NoteDataSourceDelegate {
    func dataSourceWillChangeContent(_ dataSource: NoteDataSourceProtocol) {
        tableView.beginUpdates()
    }
    
    func dataSourceDidChangeContent(_ dataSource: NoteDataSourceProtocol) {
        updateToolBar()
        tableView.endUpdates()
    }
    
    func dataSource(_ dataSource: NoteDataSourceProtocol, didChange note: NoteProtocol, at indexPath: IndexPath?, for type: DataSourceChangeType, newIndexPath: IndexPath?) {
        
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
               let cell = tableView.cellForRow(at: indexPath) as? NoteViewCell {
                cell.setupView(note: note)
            }
        }
    }
}

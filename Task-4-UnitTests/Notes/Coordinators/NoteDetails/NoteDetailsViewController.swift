//
//  NoteDetailsViewController.swift
//  Notes
//
//

import UIKit

class NoteDetailsViewController: UIViewController {
    
    var viewModel: NoteDetailsViewModel!

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setToolbarHidden(true, animated: true)
        navigationController?.navigationBar.backItem
        navigationController?.navigationBar.backItem?.accessibilityLabel = "navigate_back_button"
        noteTextView.accessibilityIdentifier = "note_text_view"
        
        dateLabel.text = viewModel.creationDateTitle
        noteTextView.text = viewModel.body
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let text = noteTextView.text {
            viewModel.update(body: text)
        }
    }
}

//
//  ViewController.swift
//  Task-6-UIFromCode
//
//  Created by Anastasiia Farafonova on 05.12.2021.
//

import UIKit

class DialogsListViewController: UIViewController {
    private enum Const {
        static let separatorInset = UIEdgeInsets(top: 0, left: 90, bottom: 0, right: 0)
        static let estimatedRowHeight: CGFloat = 90
        static let numberOfSections = 1
        static let reuseIdentifier = "DialogCell"
        static let refreshControlTitle = "Pull to refresh"
    }
    
    private lazy var dialogsList = UITableView()
    private lazy var refreshControl = UIRefreshControl()
    
    var viewModel: DialogListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dialogsList.delegate = self
        dialogsList.dataSource = self
        dialogsList.register(ConversationCell.self, forCellReuseIdentifier: "DialogCell")

        setupSubviews()
        setupAutolayaout()
    }
    
    @objc private func refresh() {
        viewModel?.refresh() { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.dialogsList.reloadData()
        }
    }
    
    private func setupSubviews() {
        view.addSubview(dialogsList)
        dialogsList.translatesAutoresizingMaskIntoConstraints = false
        dialogsList.estimatedRowHeight = Const.estimatedRowHeight
        
        refreshControl.attributedTitle = NSAttributedString(string: Const.refreshControlTitle)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        dialogsList.addSubview(refreshControl)
        dialogsList.separatorInset = Const.separatorInset
    }
    
    private func setupAutolayaout() {
        NSLayoutConstraint.activate([
            dialogsList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dialogsList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dialogsList.topAnchor.constraint(equalTo: view.topAnchor),
            dialogsList.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DialogsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.conversationViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dialogsList.dequeueReusableCell(withIdentifier: Const.reuseIdentifier) as? ConversationCell ?? ConversationCell()
        cell.viewModel = viewModel?.conversationViewModels[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Const.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dialogsList.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let indexForLastVisibleRow = dialogsList.indexPathsForVisibleRows?.last?.row else { return }
        
        if (indexForLastVisibleRow + 1) == viewModel?.conversationViewModels.count {
            viewModel?.fetchConversations() { [weak self] in
                self?.dialogsList.reloadData()
            }
        }
    }
}


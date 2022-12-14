//
//  ViewController.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 01/11/22.
//

import UIKit

class PRViewController: UIViewController {
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var errorStateView: UIView!
    @IBOutlet weak var prListView: UIView!
    @IBOutlet weak var pullRequestTableView: UITableView!
    let prViewControllerViewModel = PRViewModel()

    var uiModels: [PRUIViewModel]? = nil{
        didSet{
            self.reloadTableView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVC()
        fetchPRs()
    }

    //MARK:- Initialize and setup UI
    private func initializeVC(){
        self.viewSetter()
        self.nibRegistering()
        self.setupAutomaticHeightTable()
    }

    private func fetchPRs() {
        self.view.showLoader()
        prViewControllerViewModel.fetchPRs {[weak self] uiModels, error in
            guard let self = self else { return }

            self.view.hideLoader()

            if let uiModels = uiModels, uiModels.count > 0 {
                self.uiModels = uiModels
            }else {
                self.viewSetter(true)
                self.warningLabel.text = self.prViewControllerViewModel.errorMapper(error: error)
            }
        }
    }

    private func setupAutomaticHeightTable() {
        pullRequestTableView.estimatedRowHeight = 100
        pullRequestTableView.rowHeight = UITableView.automaticDimension
    }

    private func viewSetter(_ isError: Bool = false) {
        self.errorStateView.isHidden = !isError
        self.prListView.isHidden = isError
    }

    //MARK:- TableView Setting
    private func reloadTableView(){
        self.pullRequestTableView.isHidden = false
        self.pullRequestTableView.delegate = self
        self.pullRequestTableView.dataSource = self
        self.pullRequestTableView.reloadData()
    }

    private func nibRegistering(){
        self.pullRequestTableView.register(UINib(nibName: PRCellViewLayout.className, bundle: nil), forCellReuseIdentifier: PRCellViewLayout.className)
        self.pullRequestTableView.register(UINib(nibName: PRLoadingCell.className, bundle: nil), forCellReuseIdentifier: PRLoadingCell.className)
    }
}

extension PRViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.uiModels?.count ?? 0
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let uiModels = self.uiModels, let cell = tableView.dequeueReusableCell(withIdentifier: PRCellViewLayout.className) as? PRCellViewLayout{
                cell.setupCell(uiModel: uiModels[safe: indexPath.row])
                cell.selectionStyle = .none
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: PRLoadingCell.className) as? PRLoadingCell{
                cell.startAnimating()
                return cell
            }
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let uiModels = self.uiModels, indexPath.row == uiModels.count - 1, !prViewControllerViewModel.isLoading {
            prViewControllerViewModel.didLoadNextPage {[weak self] uiModels, error in
                guard let self = self else { return }
                self.uiModels = uiModels
            }
        }
    }
}


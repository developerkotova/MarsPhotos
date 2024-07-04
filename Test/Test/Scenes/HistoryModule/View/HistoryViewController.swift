//
//  HistoryViewController.swift
//  Test
//
//  Created by  Лиза Котова on 01.07.2024.
//

import UIKit

protocol HistoryViewProtocol: AnyObject {
    func configure(with model: HistoryViewModel)
}

final class HistoryViewController: UIViewController {
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var emptyImageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: HistoryPresenterProtocol!
    
    enum Section {
        case first
    }
    
    struct Row: Hashable {
        let id = UUID().uuidString
        let filter: String
        let rover: String
        let camera: String
        let date: String
    }
    
    var dataSource: UITableViewDiffableDataSource<Section, Row>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureDataSource()
               applyInitialSnapshot()
    }
}

extension HistoryViewController: HistoryViewProtocol {
    func configure(with model: HistoryViewModel) {
    }
}

// MARK: - Privates
private extension HistoryViewController {
    // MARK: - Actions
    @IBAction func didTapBack(_ sender: Any) {
        presenter.onBackAction()
    }
    // MARK: - Methods
    func setupTableView() {
        tableView.delegate = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryTableViewCell")
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Row>(tableView: tableView) { tableView, indexPath, row in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as? HistoryTableViewCell else {
                return UITableViewCell()
            }
            cell.configurCell(with: HistoryTableViewModel(
                filter: row.filter,
                rover: row.rover,
                camera: row.camera,
                date: row.date
            ))
            return cell
        }
    }
        
        func applyInitialSnapshot() {
                var snapshot = NSDiffableDataSourceSnapshot<Section, Row>()
                snapshot.appendSections([.first])
                
                let rows = (1...10).map { _ in
                    Row(filter: "Filter",
                        rover: "Rover:  Curiosity",
                        camera: "Camera:  Front Hazard Avoidance Camera",
                        date: "Date:  June 6, 2019")
                }
                snapshot.appendItems(rows, toSection: .first)
                dataSource.apply(snapshot, animatingDifferences: true)
            }
}

extension HistoryViewController: UITableViewDelegate {
    
}

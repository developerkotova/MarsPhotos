//
//  HomeViewController.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func configure(with model: HomeViewModel)
    func reloadData(with items: [RoverItem])
    func setLoader(_ value: Bool)
    func showError(with error: String)
}

final class HomeViewController: UIViewController {
    @IBOutlet private weak var noDataLabel: UILabel!
    @IBOutlet private weak var tableViewLoader: UIActivityIndicatorView!
    @IBOutlet private weak var activityView: UIActivityIndicatorView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var systemFilterView: FilterView!
    @IBOutlet private weak var cameraFilterView: FilterView!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var historyButton: UIButton!
    private var calendarView: CalendarView?
    private var filterView: PickFilterView?
    private var dataSource: UITableViewDiffableDataSource<Section, RoverItem>!
    private var rover: Rovers = .curiosity
    private var camera: Cameras? = nil
    private var selectedDate = Date()
    private var currentPage = 1
    private var isLoading = false
    private var viewModel: HomeViewModel?
    private var filterType: FilterViewModel.FilterType = .camera
    
    var presenter: HomePresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addGestures()
        setupTableView()
        presenter.onAppear()
    }
}

extension HomeViewController: HomeViewProtocol {
    func showError(with error: String) {
        let alertController = UIAlertController(
            title: error,
            message: nil,
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func setLoader(_ value: Bool) {
        tableView.isHidden = value
        activityView.isHidden = !value
        if value {
            activityView.startAnimating()
        } else {
            activityView.stopAnimating()
        }
    }
    
    func reloadData(with items: [RoverItem]) {
        setLoader(false)
        setTableViewLoader(false)
        isLoading = false
        noDataLabel.isHidden = !items.isEmpty
        var snapshot = NSDiffableDataSourceSnapshot<Section, RoverItem>()
        snapshot.appendSections([.first])
        snapshot.appendItems(items, toSection: .first)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func configure(with model: HomeViewModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        systemFilterView.configure(with: model.systemFilter)
        cameraFilterView.configure(with: model.cameraFilter)
        viewModel = model
    }
}

// MARK: - Privates
private extension HomeViewController {
    // MARK: - Actions
    @IBAction func didTapCalendar(_ sender: Any) {
        calendarView = CalendarView()
        guard let calendarView = calendarView else {return}
        calendarView.setDate(selectedDate)
        self.view.addSubview(calendarView)
        calendarView.frame = self.view.bounds
        calendarView.delegate = self
    }
    
    @IBAction func didTapAdd(_ sender: Any) {
        let alertController = UIAlertController(
            title: "Save Filters",
            message: "The current filters and the date you have chosen can be saved to the filter history.",
            preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .cancel) { _ in
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func didTapSystem() {
        filterType = .rover
        showPickerView()
        
    }
    
    @objc func didTapCamera() {
        filterType = .camera
        showPickerView()
    }
    
    @IBAction func didTapHistory(_ sender: Any) {
        presenter.openHistory()
    }
    
    // MARK: - Methods
    func showPickerView() {
        filterView = PickFilterView()
        guard let filterView = filterView else {return}
        switch filterType {
        case .camera:
            filterView.configure(with: PickFilterViewModel(
                title: "Camera",
                dataSource: viewModel?.cameraFilter.type.data ?? []))
        case .rover:
            filterView.configure(with: PickFilterViewModel(
                title: "Rover",
                dataSource: viewModel?.systemFilter.type.data ?? []))
        }
        self.view.addSubview(filterView)
        filterView.frame = self.view.bounds
        filterView.show(in: self.view)
        filterView.delegate = self
    }
    
    func setupUI() {
        addButton.corderRadius(10, corners: .all)
        tableViewLoader.isHidden = true
    }
    
    func addGestures() {
        let systemTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSystem))
        let cameraTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCamera))
        systemFilterView.addGestureRecognizer(systemTapGesture)
        cameraFilterView.addGestureRecognizer(cameraTapGesture)
    }
    
    func setupTableView() {
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        tableView.delegate = self
        dataSource = UITableViewDiffableDataSource<Section, RoverItem>(tableView: tableView) { (tableView, indexPath, item) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
                return UITableViewCell()
            }
            cell.configurCell(with: HomeTableViewModel(rover: item.rover, camera: item.camera, date: item.date, image: item.image))
            return cell
        }
    }
    
    func setTableViewLoader(_ value: Bool) {
        tableViewLoader.isHidden = !value
        if value {
            tableViewLoader.startAnimating()
        } else {
            tableViewLoader.stopAnimating()
        }
    }
    
    enum Section {
        case first
    }
}

// MARK: - CalendarViewDelegate
extension HomeViewController: CalendarViewDelegate {
    func didSelectDate(_ date: Date) {
        noDataLabel.isHidden = true
        selectedDate = date
        subtitleLabel.text = date.toString(format: .long)
        presenter.filterData(with: rover, camera: camera, and: selectedDate)
    }
}

// MARK: - PickFilterViewDelegate
extension HomeViewController: PickFilterViewDelegate {
    func didPickFilter(_ filter: String) {
        switch filterType {
        case .camera:
            if let camera = Cameras.from(fullName: filter) {
                self.camera = camera
                cameraFilterView.updateTitle(with: self.camera?.rawValue.capitalized ?? "")
            }
        case .rover:
            if let rover = Rovers.from(fullName: filter) {
                if self.rover != rover {
                    currentPage = 1
                }
                self.rover = rover
                systemFilterView.updateTitle(with: self.rover.fullName)
            }
        }
        noDataLabel.isHidden = true
        presenter.filterData(with: rover, camera: camera, and: selectedDate)
    }
}

extension HomeViewController: UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height && !isLoading {
            setTableViewLoader(true)
            isLoading = true
            currentPage += 1
            presenter.fetchPhotos(
                from: rover,
                camera: camera,
                and: selectedDate.toString(format: .short),
                with: currentPage)
        }
    }
}



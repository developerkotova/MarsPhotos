//
//  HomePresenter.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func onAppear()
    func openHistory()
    func fetchPhotos(
        from rover: Rovers,
        camera: Cameras?,
        and date: String,
        with page: Int)
    func filterData(with rover: Rovers, camera: Cameras?, and date: Date)
}

final class HomePresenter {
    weak var view: HomeViewProtocol?
    private let router: HomeRouter
    private let networkService: NetworkServiceProtocol
    private var sectionItems = [RoverItem]()
    private var filteredSectionItems = [RoverItem]()
    private var rover: Rovers = .curiosity
    private var camera: Cameras? = nil
    private var selectedDate = Date() 
    init(
        view: HomeViewProtocol,
        router: HomeRouter,
        networkService: NetworkServiceProtocol) {
            self.view = view
            self.router = router
            self.networkService = networkService
        }
}

extension HomePresenter: HomePresenterProtocol {
    func filterData(
        with rover: Rovers,
        camera: Cameras?,
        and date: Date
    ) {
        let formattedDate = date.toString(format: .short)
        filteredSectionItems = sectionItems.filter { item in
                let matchesRover = item.rover.contains(rover.fullName)
                let matchesCamera = camera == nil || item.camera.contains(camera!.fullName)
                let matchesDate = item.date.contains(formattedDate)
                return matchesRover && matchesCamera && matchesDate
        }
        if self.rover != rover || (self.selectedDate != date && filteredSectionItems.isEmpty){
            sectionItems = []
            filteredSectionItems = []
            view?.setLoader(true)
            fetchPhotos(from: rover, camera: camera, and: date.toString(format: .short), with: 1)
        } else {
            view?.reloadData(with: filteredSectionItems)
        }
        self.selectedDate = date
        self.camera = camera
        self.rover = rover
    }
    
    func fetchPhotos(
        from rover: Rovers,
        camera: Cameras?,
        and date: String,
        with page: Int
    ) {
        networkService.fetchPhotos(
            from: rover,
            camera: camera,
            and: date,
            with: page
        ) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let photos):
                photos.forEach { photo in
                    let item = RoverItem(
                        rover: "Rover: \(photo.rover.name)",
                        camera: "Camera: \(photo.camera.fullName)",
                        date: "Date: \(photo.earthDate)",
                        image: photo.imgSrc
                    )
                    if !self.sectionItems.contains(item) {
                        self.sectionItems.append(item)
                    }
                }
                filteredSectionItems = sectionItems
                onMainQueue {
                    self.view?.reloadData(with: self.sectionItems)
                }
            case .failure(let error):
                self.view?.showError(with: error.localizedDescription)
            }
        }
    }
    
    
    func openHistory() {
        router.openModule(HistoryModule())
    }
    
    func onAppear() {
        view?.setLoader(true)
        fetchPhotos(from: .curiosity, camera: nil, and: selectedDate.toString(format: .short), with: 1)
        let viewModel = HomeViewModel(
            title: "MARS.CAMERA",
            subtitle: selectedDate.toString(format: .long),
            systemFilter: FilterViewModel(
                title: rover.fullName,
                imageName: "cpu",
                type: .rover),
            cameraFilter: FilterViewModel(
                title: "All",
                imageName: "camera",
                type: .camera))
        
        view?.configure(with: viewModel)
    }
}

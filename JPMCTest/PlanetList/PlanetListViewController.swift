//
//  PlanetListViewController.swift
//  JPMCTest
//
//  Created by Darshan Gajera on 08/05/2023.
//

import UIKit

class PlanetListViewController: UIViewController {
    
    //MARK: Public Properties
    @IBOutlet weak var planetTableView: UITableView? {
        didSet {
            planetTableView?.delegate = self
            planetTableView?.dataSource = self
            planetTableView?.register(UINib(nibName: PlanetCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: PlanetCell.reuseIdentifier)
            
            planetTableView?.addSubview(refreshControl)
        }
    }
    public var viewModel = PlanetListViewModel()
    
    //MARK: Private Properties
    lazy private var refreshControl: UIRefreshControl = {
           let refreshControl = UIRefreshControl()
           refreshControl.addTarget(self, action:
                                       #selector(refresh(_:)),
                                    for: UIControl.Event.valueChanged)
           refreshControl.tintColor = UIColor.gray
           return refreshControl
       }()
    
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = PlanetListViewModel.Strings.planets
        fetchPlanets()
    }
    
    //MARK: Methods
    public func fetchPlanets() {
        Task {
            do {
                LoadingView.show()
                try await viewModel.fetchAllPlanetFromAPI()
                LoadingView.hide()
                planetTableView?.reloadData()
            } catch let err {
                LoadingView.hide()
                debugPrint(err.localizedDescription)
            }
        }
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        fetchPlanets()
        refreshControl.endRefreshing()
    }
}
 
//MARK: Tableview methods
extension PlanetListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noOfPlanets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlanetCell = tableView.dequeueReusableCell(for: indexPath)
        guard let planetData = viewModel.dataForRowAt(indexPath) else { return UITableViewCell() }
        cell.setData(planetData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//
//  ViewController.swift
//  iOSCourseWork1
//
//  Created by Ильдар Залялов on 24.08.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit
import Foundation

class ListOfFilmsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate, DetailViewControllerDelegate, UISearchResultsUpdating {
    
    private var timer: Timer?
    private var filteredModels: [FilmData] = []
    private var searchBarText: String? = nil
    private var isSearchBarEmpty: Bool {
        return searchBarText?.isEmpty ?? true
    }
    private var searchControllerisActive: Bool = false
    /// check if search bar is in use
    private var isFiltering: Bool {
        return searchControllerisActive
    }
    
    @IBOutlet weak private var tableView: UITableView!
    
    private var model: FilmDataManager?
    private var models = [FilmData]()
    
    private let refreshControl = UIRefreshControl()
    private let dataManager = DataManager()
    private var loggedUser = User()
    var isEditMode: Bool = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        model = FilmDataManager()
        
        obtainDataAndReloadTable()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let cellNib = UINib(nibName: Metrics.nibName, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: Metrics.tableCellIdentifier)
        
        refreshControl.addTarget(self, action: #selector(self.refreshTable(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.estimatedRowHeight = 150
    }
    
    /// Function updates the table and shuffles the rows
    @objc func refreshTable(_ sender: AnyObject) {
        obtainDataAndReloadTable(shuffleMode: true)
        refreshControl.endRefreshing()
    }
    //MARK: table initializaion
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredModels.count
        }
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Metrics.tableCellIdentifier, for: indexPath) as! CustomTableViewCell
        
        let data: FilmData
        if isFiltering {
            data = filteredModels[indexPath.row]
        } else {
            data = models[indexPath.row]
        }
        
        cell.configure(with: data)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Metrics.heightOfSectionHeader
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(loggedUser.name ?? "" ) \(loggedUser.surname ?? "")"
    }
    
    //MARK: action when row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let filmModel: FilmData
        if isFiltering {
            filmModel = filteredModels[indexPath.row]
        } else {
            filmModel = models[indexPath.row]
        }
        let configuration = DetailViewControllerConfiguration(data: filmModel, cellIndexPath: indexPath, isEditMode: isEditMode)
        performSegue(withIdentifier: Metrics.detailSegueIdentifier, sender: configuration)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Metrics.detailSegueIdentifier {
            
            guard let destinationController = segue.destination as? DetailViewController else {
                return
            }
            
            guard let configuration = sender as? DetailViewControllerConfiguration else {
                return
            }
            
            destinationController.delegate = self
            destinationController.configuration = configuration
        }
    }
    
    //MARK: rating alert
    /// Function opens alert with films rating
    /// - Parameter rate: rating
    func didPressCustomCellACtion(with rate: Int) {
        let alertController = UIAlertController(title: Metrics.ratingAlertTitle, message: Metrics.ratingAlertMessage + String(rate), preferredStyle: .alert)
        let okButton = UIAlertAction(title: Metrics.ratingAlertOkButtonTitle, style: .default, handler: nil)
        
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: updating image and description of the film
    /// Function updates image and desctiption of the film
    /// - Parameters:
    ///   - updatedFilm:
    ///   - indexPath:
    func updateImageAndDescription(updatedFilm: FilmData, indexPath: IndexPath) {
        models.remove(at: indexPath.row)
        models.insert(updatedFilm, at: indexPath.row)
        
        loggedUser.filmData = models
        dataManager.saveLoggedUserData(userToSave: self.loggedUser) {[weak self] in
            self?.obtainDataAndReloadTable()
        }
    }
    
    //MARK:update results when user types in searchbar
    /// Function updates the  list of movies when the user types int the searchbar.
    /// - Parameter searchController: searchController
    func updateSearchResults(for searchController: UISearchController) {
        self.isEditMode = false
        searchController.showsSearchResultsController = true
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: Metrics.beginToSearchDelay, repeats: false, block: { Timer in
            searchController.showsSearchResultsController = true
            
            self.searchBarText = searchController.searchBar.text?.trimmingCharacters(in: CharacterSet.whitespaces) ?? ""
            self.searchControllerisActive = searchController.isActive
            
            if !self.isSearchBarEmpty {
                self.dataManager.obtainFilteredResults(searchText: self.searchBarText ?? "") {[weak self] models in
                    self?.filteredModels = models
                    self?.tableView.reloadData()
                }
            }
            else {
                self.filteredModels = self.models
                self.tableView.reloadData()
            }
        })
    }
    
    /// Function obtain data from dataManager and reload resuilts in the table
    func obtainDataAndReloadTable(shuffleMode: Bool = false) {
        dataManager.obtainLoggedUserData {[weak self] userData in
            self?.loggedUser = userData
            self?.models = self?.loggedUser.filmData ?? [FilmData(imageName: Data())]
            self?.filteredModels = self?.models ?? [FilmData(imageName: Data())]
            if shuffleMode {
                self?.models.shuffle()
            }
            self?.tableView.reloadData()
        }
    }
}

extension ListOfFilmsViewController {
    enum Metrics {
        static let detailSegueIdentifier: String = "detailSegue"
        static let nibName: String = "CustomTableViewCell"
        static let heightOfSectionHeader: CGFloat = 30
        static let tableCellIdentifier: String = "cell"
        static let ratingAlertTitle: String = "Rate"
        static let ratingAlertMessage: String = "Rating: "
        static let ratingAlertOkButtonTitle: String = "Ok"
        static let beginToSearchDelay: Double = 0.3
    }
}

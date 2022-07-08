//
//  SearchViewController.swift
//  iOSCourseWork1
//
//  Created by max on 24.03.2022.
//  Copyright © 2022 Ildar Zalyalov. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var filmsController: ListOfFilmsViewController!
    
    private var filmsList: [[String]]!
    private let dataManager = FilmDataManager()
    private let storyBoardFactory = StoryBoardFactory()
    
    let lineView: UIImageView = {
        let image = UIImage(systemName: Metrics.lineViewImageName)
        let icon = UIImageView(image: image)
        icon.contentMode = .center
        icon.tintColor = .systemGray
        return icon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmsList = dataManager.obtainListOfFilms()
        searchControllerSetup()
        setupViews()
    }
    
    func searchControllerSetup() {
        
        filmsController = storyBoardFactory.obtainScreenController(storyboardName: StoryBoardName.moviesStoryBoard.storyBoardTitle, identifier: StoryBoardName.moviesStoryBoard.storyBoardIdentifier) as? ListOfFilmsViewController
        filmsController.modalPresentationStyle = .fullScreen
        filmsController.modalTransitionStyle = .coverVertical
        filmsController.isEditMode = false
  
        
        let searchController = UISearchController(searchResultsController: filmsController)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchResultsUpdater = filmsController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Metrics.searchBarPlaceholderText
        
        searchController.searchBar.setSearchFieldBackgroundImage(UIImage.imageWithColor(color: UIColor.systemFill, size: CGSize(width: 1, height: Metrics.searchBarHeight)), for: .normal)
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(systemName: Metrics.searchBarSettingsImage), for: .bookmark, state: .normal)
        searchController.searchBar.setImage(UIImage(systemName: Metrics.searchBarSettingsImage), for: .bookmark, state: .selected)
        
        searchController.searchBar.searchTextField.layer.cornerRadius = Metrics.searchBarTextFieldCornerRadius
        searchController.searchBar.searchTextField.clipsToBounds = true
        definesPresentationContext = true
        
        searchController.searchBar.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.centerYAnchor.constraint(equalTo: searchController.searchBar.searchTextField.centerYAnchor).isActive = true
        lineView.leftAnchor.constraint(equalTo:  searchController.searchBar.searchTextField.rightAnchor, constant: Metrics.lineViewLeftMargin).isActive = true
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellWithListOfFilms.self, forCellReuseIdentifier: TableCellIdentifiers.filmsCellIdentifier)
        tableView.register(CellWithCashListOfFilms.self, forCellReuseIdentifier: TableCellIdentifiers.cashFilmsCellIdentifier)
        tableView.register(CellWithPopularActers.self, forCellReuseIdentifier: TableCellIdentifiers.popularActersCellIdentifier)
        return tableView
    }()
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.edgeTo(view)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Table.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows: Int = 0
        
        switch section {
        case 0:
            numberOfRows = Table.rowsInFirstSection
        case 1:
            numberOfRows = Table.rowsInSecondSection
        default:
            numberOfRows = Table.rowsInThirdSection
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight: CGFloat = 0
        
        switch indexPath.section {
        case 0,1:
            rowHeight = Table.rowHeight
        default:
            rowHeight = Table.uicollectionRowHeight
        }
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Table.heightOfHeader
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.filmsCellIdentifier, for: indexPath) as! CellWithListOfFilms
            cell.titleLabel.text = filmsList[indexPath.section][indexPath.row]
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.cashFilmsCellIdentifier, for: indexPath) as! CellWithCashListOfFilms
            cell.titleLabel.text = filmsList[indexPath.section][indexPath.row]
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.popularActersCellIdentifier, for: indexPath) as! CellWithPopularActers
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = CellHeader(frame: CGRect(x: 0 , y: 0, width: tableView.frame.width, height: tableView.frame.height))
            view.titleLabel.text = TableHeaders.filmsTitle
            return view
        case 1:
            let view = CellHeader(frame: CGRect(x: 0 , y: 0, width: tableView.frame.width, height: tableView.frame.height))
            view.titleLabel.text = TableHeaders.cashFilmsTitle
            return view
        default:
            let view = CellHeaderWithButton(frame: CGRect(x: 0 , y: 0, width: tableView.frame.width, height: tableView.frame.height))
            view.titleLabel.text = TableHeaders.popularActersTitle
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.show(filmsController, sender: nil)
    }
}

extension SearchViewController {
    enum TableHeaders {
        static let filmsTitle: String = "Фильмы"
        static let cashFilmsTitle: String = "Кассовые сборы"
        static let popularActersTitle: String = "Самые популярные персоны"
    }
    enum TableCellIdentifiers {
        static let filmsCellIdentifier: String = "cellWithListOfFilms"
        static let cashFilmsCellIdentifier: String = "cellWithCashListOfFilms"
        static let popularActersCellIdentifier: String = "cellWithPopularActers"
    }
    enum Table {
        static let numberOfSections: Int = 3
        static let heightOfHeader: CGFloat = 20
        static let rowHeight: CGFloat = 50
        static let uicollectionRowHeight: CGFloat = 150
        static let rowsInFirstSection: Int = 5
        static let rowsInSecondSection: Int = 2
        static let rowsInThirdSection: Int = 1
        
    }
    enum Metrics {
        static let lineViewImageName: String = "poweron"
        static let searchBarPlaceholderText: String = "Фильмы, персоны, кинотеатры"
        static let searchBarSettingsImage: String = "slider.horizontal.3"
        static let searchBarTextFieldCornerRadius: CGFloat = 2.0
        static let lineViewLeftMargin: CGFloat = -40
        static let searchBarHeight: CGFloat = 48
    }
}

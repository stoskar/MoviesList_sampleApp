//
//  MoviesSearchViewController.swift
//  assignment
//
//  Created by IOS Developer6 on 15/02/18.
//  Copyright © 2018 sachin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MoviesSearchViewController: UIViewController {
   
    @IBOutlet weak var moviesSearchTblView: UITableView!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    var page = 1
    var query = String()
    
    var searchData = [SearchApiModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieSearchBar.delegate = self
        registerNibForTableViewCell()
        self.title = "Search"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        
    }
    
    func registerNibForTableViewCell() {
        
        moviesSearchTblView.register(UINib(nibName: "SearchMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchMoviesTableViewCell")
    }
   
    
    func searchPostsAPI() {
        
        if (Utility_Swift.isInternetConnected(isShowPopup: true)) {
            
            var dictionaryHeaders = [String : String]()
            dictionaryHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
            
            let apiURL =  BASE_URL + SEARCH_MOVIES
            let parametarDictionary = ["api_key": API_KEY,
                                       "language": LANGUAGE,
                                       "query":query,
                                       "page":String(page)]
            Alamofire.request(apiURL, method: .get, parameters:parametarDictionary, headers:dictionaryHeaders)
                .responseJSON { response in
                    switch response.result {
                    case .success(let responseValue) :
                        
                        if let tempDict = responseValue as? NSDictionary {
                            if let tempArray = tempDict["results"] as? NSArray {
                                for singleData in tempArray {
                                    guard let searchResult = SearchApiModel(dictionary:singleData as! NSDictionary) else {
                                        return
                                    }
                                    self.searchData.append(searchResult)
                                }
                                
                                self.moviesSearchTblView.reloadData()
                            }
                        }
                        
                    case .failure(let error) :
                        print(error)
                    }
            }
        }
    }

}



extension MoviesSearchViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let searchSingleData = self.searchData[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMoviesTableViewCell") as! SearchMoviesTableViewCell
        tableView.tableFooterView = UIView(frame: .zero)
        cell.moviesName?.text = searchSingleData.title
        cell.dateLbl?.text = searchSingleData.releaseDate
        cell.posterImg.image = #imageLiteral(resourceName: "poster-placeholder")
        
        if (searchSingleData.posterPath != nil) {
            let posterUrl = POSTER_BASE_URL + searchSingleData.posterPath
            print(posterUrl)
            
            cell.posterImg.af_setImage(withURL: URL(string: posterUrl)!)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.searchData.count - 1 { // last cell
            page += 1
            searchPostsAPI()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let searchSingleData = self.searchData[indexPath.row]
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesDetailsVC = storyboard.instantiateViewController(withIdentifier: "MoviesDetailsViewController") as! MoviesDetailsViewController
        moviesDetailsVC.moviesID = searchSingleData.id
        
        
        self.navigationController?.pushViewController(moviesDetailsVC, animated:true)

    }
}

extension MoviesSearchViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        query = searchText
        searchPostsAPI()
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.movieSearchBar.showsCancelButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.movieSearchBar.showsCancelButton = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

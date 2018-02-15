//
//  MoviesListCollectionViewController.swift
//  assignment
//
//  Created by IOS Developer6 on 15/02/18.
//  Copyright © 2018 sachin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MoviesListCollectionViewController: UIViewController {
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var segmentoutlet: UISegmentedControl!
    
    var page = 1
    var movies = [MoviesModel]()
    var moviesFilter = POPULAR_MOVIES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.moviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        moviesPostsAPI()
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
    func moviesPostsAPI() {
        
        if (Utility_Swift.isInternetConnected(isShowPopup: true)) {
            
            var dictionaryHeaders = [String : String]()
            dictionaryHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
            
            let parametarDictionary = ["api_key": API_KEY,
                                       "page":String(page)]
            
            let apiURL =  BASE_URL + moviesFilter
            
            Alamofire.request(apiURL, method: .get, parameters:parametarDictionary, headers:dictionaryHeaders)
                .responseJSON { response in
                    
                    switch response.result {
                    case .success(let responseValue) :
                        
                        if let tempDict = responseValue as? NSDictionary {
                            if let tempArray = tempDict["results"] as? NSArray {
                                for singleData in tempArray {
                                    
                                    guard let moviesResult = MoviesModel(dictionary:singleData as! NSDictionary) else {
                                        return
                                    }
                                    self.movies.append(moviesResult)
                                }
                                self.moviesCollectionView.reloadData()
                                
                            }
                        }
                        
                    case .failure(let error) :
                        print(error)
                    }
                    
            }
        }
    }
    

}

extension MoviesListCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movieInfo = self.movies[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.white.cgColor
        cell.movieTitleLabel.text = movieInfo.title
        cell.movieDateLabel.text = movieInfo.releaseDate
        
        cell.movieImgView.image = #imageLiteral(resourceName: "poster-placeholder")
        
        if (movieInfo.posterPath != nil) {
            let posterUrl = POSTER_BASE_URL + movieInfo.posterPath
            print(posterUrl)
            
            cell.movieImgView.af_setImage(withURL: URL(string: posterUrl)!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat = view.frame.size.height
        let width: CGFloat = view.frame.size.width
        
        return CGSize(width: width/3-10 , height: height/4-10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        
        if indexPath.row == movies.count - 1 { // last cell
            page += 1
            moviesPostsAPI()
        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            collectionView.deselectItem(at: indexPath, animated: true)
        let moviesSingleData = self.movies[indexPath.row]
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesDetailsVC = storyboard.instantiateViewController(withIdentifier: "MoviesDetailsViewController") as! MoviesDetailsViewController
        moviesDetailsVC.moviesID = moviesSingleData.id
        
        self.navigationController?.pushViewController(moviesDetailsVC, animated:true)
        
    }

    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentoutlet.selectedSegmentIndex {
        case 0:
            moviesFilter = POPULAR_MOVIES
            page = 1
            movies.removeAll()
            moviesPostsAPI()
        case 1:
            moviesFilter = TOP_MOVIES
            page = 1
            movies.removeAll()
            moviesPostsAPI()
        default:
            break;
        }
    }
    
}


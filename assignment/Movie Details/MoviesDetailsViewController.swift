//
//  MoviesDetailsViewController.swift
//  assignment
//
//  Created by IOS Developer6 on 15/02/18.
//  Copyright © 2018 sachin. All rights reserved.
//

import UIKit
import Alamofire
class MoviesDetailsViewController: UIViewController {

    @IBOutlet weak var moviePosterImg: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var rating: UILabel!

    var activityIndicator = UIActivityIndicatorView()
    var moviesID = Int()
    
    var movieDetails: MoviesDetailsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = self.view.center
        self.view .addSubview(activityIndicator)
        self.title = "Movie Details"
        
        moviesDetailsPostsAPI()
        // Do any additional setup after loading the view.
    }


    
    func moviesDetailsPostsAPI() {
        
        if (Utility_Swift.isInternetConnected(isShowPopup: true)) {
            
            activityIndicator.startAnimating()
            
            var dictionaryHeaders = [String : String]()
            dictionaryHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
            
            let apiURL =  BASE_URL + MOVIE_DETAILS + String(moviesID) + "?"
            
            let parametarDictionary = ["api_key": API_KEY,
                                       "language": LANGUAGE]
            
            Alamofire.request(apiURL, method: .get, parameters:parametarDictionary, headers:dictionaryHeaders)
                .responseJSON { response in
                    switch response.result {
                    case .success(let responseValue) :
                        
                        self.activityIndicator.stopAnimating()
                        if let tempDict = responseValue as? NSDictionary {
                           
                            guard let moviesResult = MoviesDetailsModel(dictionary: tempDict) else{
                                return
                            }
                            
                            self.movieDetails = moviesResult
                            self.setData()
                            print(self.movieDetails.originalTitle)
                        }
                        
                    case .failure(let error) :
                        print(error)
                    }
            }
        }
    }

    func setData()  {
        
            moviePosterImg.image = #imageLiteral(resourceName: "poster-placeholder")
        
        if (movieDetails.backdropPath != nil) {
            let posterUrl = POSTER_BASE_URL + movieDetails.backdropPath
            print(posterUrl)
            moviePosterImg.af_setImage(withURL: URL(string:posterUrl )!)
        }
        
        movieTitleLbl?.text = movieDetails.title
        detailLbl?.text = movieDetails.overview
        dateLbl?.text = movieDetails.releaseDate
        rating?.text = "​Vote Average : " + String(movieDetails.voteAverage) + "/10"
      
        
        
    }
    
}

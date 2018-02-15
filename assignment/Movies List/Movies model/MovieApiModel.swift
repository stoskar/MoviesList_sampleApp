//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MoviesModel{

	var adult : Bool!
	var backdropPath : String!
	var genreIds : [Int]!
	var id : Int!
	var originalLanguage : String!
	var originalTitle : String!
	var overview : String!
	var popularity : Float!
	var posterPath : String!
	var releaseDate : String!
	var title : String!
	var video : Bool!
	var voteAverage : Float!
	var voteCount : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init?(dictionary: NSDictionary){
		adult = dictionary["adult"] as? Bool
		backdropPath = dictionary["backdrop_path"] as? String
		genreIds = dictionary["genre_ids"] as? [Int]
		id = dictionary["id"] as? Int
		originalLanguage = dictionary["original_language"] as? String
		originalTitle = dictionary["original_title"] as? String
		overview = dictionary["overview"] as? String
		popularity = dictionary["popularity"] as? Float
		posterPath = dictionary["poster_path"] as? String
		releaseDate = dictionary["release_date"] as? String
		title = dictionary["title"] as? String
		video = dictionary["video"] as? Bool
		voteAverage = dictionary["vote_average"] as? Float
		voteCount = dictionary["vote_count"] as? Int
	}

}

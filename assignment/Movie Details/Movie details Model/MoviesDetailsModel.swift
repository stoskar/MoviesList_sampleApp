//
//	MoviesDetailsModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MoviesDetailsModel{

	var adult : Bool!
	var backdropPath : String!
	var belongsToCollection : Any!
	var budget : Int!
	var genres : [AnyObject]!
	var homepage : String!
	var id : Int!
	var imdbId : String!
	var originalLanguage : String!
	var originalTitle : String!
	var overview : String!
	var popularity : Float!
	var posterPath : String!
	var productionCompanies : [AnyObject]!
	var productionCountries : [AnyObject]!
	var releaseDate : String!
	var revenue : Int!
	var runtime : Int!
	var spokenLanguages : [AnyObject]!
	var status : String!
	var tagline : String!
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
        belongsToCollection = dictionary["belongs_to_collection"] as? NSDictionary
		budget = dictionary["budget"] as? Int
		genres = dictionary["genres"] as? [AnyObject]
		homepage = dictionary["homepage"] as? String
		id = dictionary["id"] as? Int
		imdbId = dictionary["imdb_id"] as? String
		originalLanguage = dictionary["original_language"] as? String
		originalTitle = dictionary["original_title"] as? String
		overview = dictionary["overview"] as? String
		popularity = dictionary["popularity"] as? Float
		posterPath = dictionary["poster_path"] as? String
		productionCompanies = dictionary["production_companies"] as? [AnyObject]
		productionCountries = dictionary["production_countries"] as? [AnyObject]
		releaseDate = dictionary["release_date"] as? String
		revenue = dictionary["revenue"] as? Int
		runtime = dictionary["runtime"] as? Int
		spokenLanguages = dictionary["spoken_languages"] as? [AnyObject]
		status = dictionary["status"] as? String
		tagline = dictionary["tagline"] as? String
		title = dictionary["title"] as? String
		video = dictionary["video"] as? Bool
		voteAverage = dictionary["vote_average"] as? Float
		voteCount = dictionary["vote_count"] as? Int
	}

}

//
//  Result.swift
//  mvvm-template
//
//  Created by Asad Hayat on 12/10/2021.
//
//  Json file generated from https://app.quicktype.io/

import Foundation

// MARK: - Welcome

struct Model: Codable {
    let resultCount: Int
    let results: [Result]
}

// MARK: - Result

struct Result: Codable {
    let wrapperType : String?
    let artistId : Int?
    let collectionId : Int?
    let artistName : String?
    let collectionName : String?
    let collectionCensoredName : String?
    let artistViewUrl : String?
    let collectionViewUrl : String?
    let artworkUrl60 : String?
    let artworkUrl100 : String?
    let collectionPrice : Double?
    let collectionExplicitness : String?
    let trackCount : Int?
    let copyright : String?
    let country : String?
    let currency : String?
    let releaseDate : String?
    let primaryGenreName : String?
    let previewUrl : String?
    let description : String?
    
    var coverPhotoUrl:String?{
        if let artworkUrl100 = artworkUrl100{
            return artworkUrl100.replacingOccurrences(of: "100x100bb.jpg", with: "1024x1024bb.jpg")
        }
        return nil
    }
}

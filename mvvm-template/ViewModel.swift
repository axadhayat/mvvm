//
//  ViewModel.swift
//  mvvm-template
//
//  Created by Asad Hayat on 13/10/2021.
//

import Foundation
import UIKit

class ViewModel{
    
    // Formatters
    
    private static let dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter
    }()
    
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter
    }()
    
    // Observers
    
    var urlString:String
    var backgroundImage : Observer<UIImage> = Observer(nil)
    var error : Observer<Error> = Observer(nil)
    var price : Observer<String> = Observer(nil)
    var releaseDate : Observer<String> = Observer(nil)
    var movieName : Observer<String> = Observer(nil)
    var artistName : Observer<String> = Observer(nil)
    
    // init
    
    init(_ urlString:String){
        self.urlString = urlString
        self.fetchItunesResult()
    }
    
}


extension ViewModel{
    func fetchItunesResult(){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                self.error.value = error
                return
            }
            if let jsonData = data{
                do{
                    let responseModel = try JSONDecoder().decode(Model.self, from: jsonData)
                    guard let result = responseModel.results.first else { return }
                    self.artistName.value = result.artistName
                    self.movieName.value = result.collectionName
                    if let releaseDate = result.releaseDate{
                        self.releaseDate.value = Self.dateFormatter.string(from: releaseDate)
                    }
                    if let collectionPrice = result.collectionPrice ,
                        let formattedPrice = Self.numberFormatter.string(from: collectionPrice as NSNumber) {
                        self.price.value = formattedPrice
                    }
                    if let coverPhotoUrl = result.coverPhotoUrl,
                        let url = URL(string: coverPhotoUrl){
                        do{
                            let imageData = try Data(contentsOf: url)
                            self.backgroundImage.value =  UIImage(data:imageData)
                        }
                        catch let imageFetcherror{
                            self.error.value = imageFetcherror
                        }
                    }
                }
                catch let jsonError{
                    self.error.value = jsonError
                }
            }
        }.resume()
    }
}

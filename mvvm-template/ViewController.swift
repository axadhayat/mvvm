//
//  ViewController.swift
//  mvvm-template
//
//  Created by Asad Hayat on 12/10/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageview: UIImageView!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var artistNameLbl: UILabel!
    
    private let urlString = "https://itunes.apple.com/search?term=AvengersEndgame&country=US&entity=movie"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchItunesResult()
    }
}

extension ViewController{
    func updateUI(with response:Model){
        guard let result = response.results.first else { return }
        self.movieNameLbl.text = result.collectionName ?? ""
        self.artistNameLbl.text = result.artistName ?? ""
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let collectionPrice = result.collectionPrice , let formattedTipAmount = formatter.string(from: collectionPrice as NSNumber) {
            priceLbl.text = formattedTipAmount
        }
        if let releaseDate = getFormattedDate(from: result.releaseDate ?? ""){
            self.releaseDateLbl.text = releaseDate
        }
        if let coverPhotoUrl = result.coverPhotoUrl,
           let url = URL(string: coverPhotoUrl),
           let data = try? Data(contentsOf: url){
            self.backgroundImageview.image = UIImage(data: data)
        }
    }
    
    func getFormattedDate(from releaseDate:String) -> String?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        if let date = formatter.date(from: releaseDate){
            formatter.dateFormat = "EEEE, MMM d, yyyy"
            return formatter.string(from: date)
        }
        return nil
    }
}

extension ViewController{
    func fetchItunesResult(){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let jsonData = data{
                do{
                    let decodedResponse = try JSONDecoder().decode(Model.self, from: jsonData)
                    DispatchQueue.main.async {
                        self.updateUI(with: decodedResponse)
                    }
                }
                catch let error{
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}

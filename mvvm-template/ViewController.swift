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
    
    private let viewModel = ViewModel("https://itunes.apple.com/search?term=AvengersEndgame&country=US&entity=movie")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    private func bindUI(){
        viewModel.backgroundImage.bind { [weak self] backgroundImage in
            guard let self = self else { return }
            self.backgroundImageview.image = backgroundImage
        }
        viewModel.price.bind { [weak self] price in
            guard let self = self else { return }
            self.priceLbl.text = price
        }
        viewModel.releaseDate.bind { [weak self] releaseDate in
            guard let self = self else { return }
            self.releaseDateLbl.text = releaseDate
        }
        viewModel.movieName.bind { [weak self] movieName in
            guard let self = self else { return }
            self.movieNameLbl.text = movieName
        }
        viewModel.artistName.bind { [weak self] artistName in
            guard let self = self else { return }
            self.artistNameLbl.text = artistName
        }
    }
}

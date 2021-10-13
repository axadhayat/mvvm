//
//  Observer.swift
//  mvvm-template
//
//  Created by Asad Hayat on 13/10/2021.
//

import Foundation

class Observer<T>{
    
    var completion:((T) -> Void)?
    
    var value:T?{
        didSet{
            guard let value = value else { return }
            DispatchQueue.main.async {
                self.completion?(value)
            }
        }
    }
    
    init(_ value:T?) {
        self.value = value
    }
}

extension Observer{
    func bind(listener:@escaping (T) -> Void){
        self.completion = listener
    }
}

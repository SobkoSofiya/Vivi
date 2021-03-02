//
//  ViewModel.swift
//  Vivi
//
//  Created by Sofi on 02.03.2021.
//

import Foundation
import SwiftUI
import SwiftyJSON
import Alamofire

class ViewModel: ObservableObject {
    @Published var pin:[Model] = []
    
    func GetVideo() {
        let url = "http://gym.areas.su/lessons"
        AF.request(url, method: .get).validate().responseJSON {[self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for i in 0..<json.count{
                    self.pin.append(Model(url: json[i]["url"].stringValue, category: json[i]["category"].stringValue))
                }
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

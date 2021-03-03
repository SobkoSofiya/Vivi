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


func signIn(email: String, password: String, completionHandler: ((_ result: String,_ error: String) -> Void)? = nil) {
            let url = "http://cinema.areas.su/auth/login"
            let parameters: [String: String] = [
                        "email": email,
                        "password": password
                    ]

            AF.request(url, method: .post, parameters:parameters, encoder: JSONParameterEncoder.default).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let token = json["token"].stringValue
                    UserDefaults.standard.set(token, forKey: "token")
                    completionHandler!(token, "Success")
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler!("", error.localizedDescription)
                }
                
            }
        }
    
    func getUser(completionHandler: ((_ result: String,_ error: String) -> Void)? = nil) {
        let url = "http://cinema.areas.su/user"
        let token = UserDefaults.standard.string(forKey: "token")!
        let headers: HTTPHeaders = [
                    "Authorization": "Bearer \(token)"
                ]
        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler!("", error.localizedDescription)
            }
            
        }
        
    }

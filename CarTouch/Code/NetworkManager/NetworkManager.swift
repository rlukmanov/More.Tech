//
//  NetworkManager.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 11.10.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import Foundation
import Alamofire
// import AlamofireImage

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getData(from image: UIImage, completion: @escaping (OfferModel?) -> Void) {
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(image.jpegData(compressionQuality: 0.5)!,withName: "img" , fileName: "file.jpeg", mimeType: "image/jpeg")
        },  to: "https://84.201.184.151:5000/", method: .post, headers: nil) .responseDecodable(of: OfferModel.self) { (response) in
                guard let carList = response.value else {
                    completion(nil)
                    return
                }
            
                completion(carList)
            }
    }
    
    func getImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        AF.request(url).responseData { (response) in
            if response.error == nil {
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                let image = UIImage(data: data)
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
    
    func postLoan() {
        let headers = [
          "x-ibm-client-id": "ИД клиента",
          "content-type": "application/json",
          "accept": "application/json"
        ]
        let parameters = [
          "comment": "Комментарий",
          "customer_party": [
            "email": "ivan@gmail.com",
            "income_amount": 420000,
            "person": [
              "birth_date_time": "1981-11-01",
              "birth_place": "г. Воронеж",
              "family_name": "Иванов",
              "first_name": "Иван",
              "gender": "female",
              "middle_name": "Иванович",
              "nationality_country_code": "RU"
            ],
            "phone": "+99999999999"
          ],
          "datetime": "2020-10-10T08:15:47Z",
          "interest_rate": 15.7,
          "requested_amount": 300000,
          "requested_term": 36,
          "trade_mark": "Nissan",
          "vehicle_cost": 600000
        ] as [String : Any]
    
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string:    "https://gw.hackathon.vtb.ru/vtb/hackathon/carloan")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData! as Data
    
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data,    response, error) -> Void in
          if (error != nil) {
            print(error)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
          }
        })
    
        dataTask.resume()
    }
}

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
        },  to: "https://84.201.184.151:5000/", method: .post , headers: nil) .responseDecodable(of: OfferModel.self) { (response) in
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
}

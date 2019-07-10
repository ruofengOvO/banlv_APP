//
//  GoogleVisionAPIManager.swift
//  WhatsThat
//
//  Created by Ismayil Hasanov on 11/10/17.
//  Copyright © 2017 GWU. All rights reserved.
//

import Foundation
import UIKit
import  SwiftyJSON
extension arplaceViewController {
  
    enum FailureReason: String {
        case networkRequestFailed = "Network request failed, please try again."
        case badJSONResponse = "Something went wrong."
        case noLabelFound = "The identification is not found for this photo."
    }
    
    // Get the label annotations from Google Vision API
    func fetchIdentifications(for image: UIImage) {
        print(" wu7 yhuiuyysyyyyyuiiuihyiuhygiughhjkhjkhkjhljlkdy98auidaiaiu")
        let requestURL = URL(string: Constants.googleVisionApiUrl)!
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = Constants.googleVisionApiMethod
        urlRequest.addValue(Constants.googleVisionApiContentType, forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        // Prepare the request data for given image
        urlRequest.httpBody = prepareJsonRequestData(for: image)
        
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) -> Void in
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print(error?.localizedDescription ?? "")
               // self.delegate?.resultsNotFound(reason: .networkRequestFailed)
                return
            }
            
            print(data)
            // Parse the results
            self.parseResults(with: data)
        }
        
        task.resume()
    }
    
    // Parse the returned result to our label model object
   func parseResults(with dataToParse: Data) {
        let dict=try?JSON(data: dataToParse)
        print(dict)
        
    }
    
    // Return the JSON given the image for Google Vision API
    func prepareJsonRequestData(for image: UIImage) -> Data? {
        // Prepare json data
        let jsonRequest = [
            "requests": [
                "image": [
                    "content": base64Encode(image)
                ],
                "features": [
                    [
                        "type": "LABEL_DETECTION",
                        "maxResults": 10
                    ]
                ]
            ]
        ]

        let data = try? JSONSerialization.data(withJSONObject: jsonRequest)
        return data
    }
    
    // Convert the image to base64 encoded string
    func base64Encode(_ image: UIImage) -> String {
        var imageData:Data = image.jpegData(compressionQuality: Constants.compressionQuality)!//(Constants.compressionQuality) ?? Data()
        
        // Resize the image if it exceeds the 2MB API limit (borrowed from Google Vision API sample)
        if (imageData.count > 2097152) {
            let oldSize = image.size
            let newSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            if let imageData = resize(image, to: newSize) {
                return imageData.base64EncodedString()
            }
        }
        
        return imageData.base64EncodedString()
    }
    
    // Resize the image to newSize (borrowed from Google Vision API sample)
    func resize(_ image: UIImage, to imageSize: CGSize) -> Data? {
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        let resizedImage = image.jpegData(compressionQuality: Constants.compressionQuality)
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

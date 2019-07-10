//
//  photoTranslate+Baidu_OCR.swift
//  test2
//
//  Created by miaoz on 2019/2/17.
//  Copyright © 2019 miaoz. All rights reserved.
//

import Foundation
import SwiftyJSON

extension PictranVC{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:Any]) {
        var image=info[.originalImage]as!UIImage
         self.imagett=image
      //  let binaryImageData = base64EncodeImage(image)
        picker.dismiss(animated: true, completion: {
            ()->Void in
        } )
        self.Image.alpha=1
        self.Image.image=image
        image=Image.screenShot()!
        self.imagett=image
        self.Image.image=image
        let binaryImageData = base64EncodeImage(image)
        createRequest(with: binaryImageData)
        //self.imageview.image=self.imagett.drawtext(text: "saas", point: CGRect(x: 50, y: 50, width: 100, height: 200))
        //var lab:UILabel
    }
    func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let resizedImage = newImage!.pngData()
        UIGraphicsEndImageContext()
        print("imageresized")
        print(imagett.size.height)
        self.imagett=newImage
        print(imagett.size.height)
        return resizedImage!
    }
    func base64EncodeImage(_ image: UIImage) -> String {
        var imagedata = image.pngData()
        if (imagedata!.count > 2097152) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            
            imagedata = resizeImage(newSize, image: image)
        }
        var tt=imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
        return tt.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
    }
    
    func createRequest(with imageBase64: String) {
        // Create our request URL
        var request = URLRequest(url: googleURL)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
        var body:String="image=" + imageBase64
        let jsonRequest = [
            "image":imageBase64
        ]
        let jsonObject = JSON(jsonRequest)
        // Serialize the JSON
        guard let data = try? jsonObject.rawData() else {
            return
        }
        request.httpBody = body.data(using: .utf8)
        
        // Run the request on a background thread
        DispatchQueue.global().async { self.runRequestOnBackgroundThread(request) }
    }
    func runRequestOnBackgroundThread(_ request: URLRequest) {
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            let json = try?JSON(data:data)
            self.ocrdate=json
            print(json)
            self.showResult(data: data)
        }
        task.resume()
    }
    func afrequest(with imagebase64:String)
    {
        var body:String="image=" + imagebase64
    }
    
}

//
//  alltool.swift
//  test2
//
//  Created by miaoz on 2019/2/17.
//  Copyright © 2019 miaoz. All rights reserved.
//

import UIKit
import SwiftyJSON
import CommonCrypto
import  ARCL
import UIKit
import SceneKit
import ARKit
extension CGRect{
    func get_point_maxl()->CGPoint{
        return CGPoint(x: self.maxX, y: self.maxY)
    }
    func get_point_minl()->CGPoint{
        return CGPoint(x: self.maxX, y: self.minY)
    }
    func get_point_maxr()->CGPoint{
        return CGPoint(x: self.minX, y: self.maxY)
    }
    func get_point_minr()->CGPoint{
        return CGPoint(x: self.minX, y: self.minY)
    }
}



extension SCNVector3{
    func drawLine( vector: SCNVector3, color:UIColor) -> SCNNode {
        let indices: [UInt32] = [0,1] // 指数    <br>       //0指：一维，表示点<br>       //1指：二维，表示线
        //数据来源
        let source = SCNGeometrySource(vertices: [self,vector])
        //画什么样的几何---选择线
        let element =  SCNGeometryElement(indices: indices, primitiveType: .line)
        let geometry = SCNGeometry(sources: [source], elements: [element])
        geometry.firstMaterial?.diffuse.contents = color
        let node = SCNNode(geometry:geometry)
        print("drawlinesucess")
        
        return node
    }
    func distance(vector: SCNVector3)->Float{
        let A=self
        let B=vector
        let l = sqrt(
            (A.x - B.x) * (A.x - B.x)
                +   (A.y - B.y) * (A.y - B.y)
                +   (A.z - B.z) * (A.z - B.z)
        )
        return Float(l)
    }
    static func positionTransform(_ transform: matrix_float4x4) -> SCNVector3{
        return SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
    }
    
}
extension ARSCNView {
    
    //拿到三维坐标
    static var flo_y:SCNVector3=SCNVector3Make(-0.023316357, -0.06513054, -0.028127845)
    func worldVector(for position:CGPoint) ->SCNVector3?{
        let results = self.hitTest(position, types: .featurePoint)
        guard let result = results.first else {
            return ARSCNView.flo_y
        }
        
        // 获取点的坐标，类型是matrix_float4x4 ,调这个方法就可以拿到相机的镜头
        ARSCNView.flo_y=SCNVector3Make( result.worldTransform.columns.3.x,result.worldTransform.columns.3.y,result.worldTransform.columns.3.z)
        print(ARSCNView.flo_y)
        return SCNVector3Make( result.worldTransform.columns.3.x,result.worldTransform.columns.3.y,result.worldTransform.columns.3.z)
        
    }
    
}

class LineNode: SCNNode
{
    init(
        v1: SCNVector3,  // where line starts
        v2: SCNVector3,  // where line ends
        material: [SCNMaterial] )  // any material.
    {
        super.init()
        let  height1 = self.distanceBetweenPoints2(A: v1, B: v2) as CGFloat //v1.distance(v2)
        
        position = v1
        
        let ndV2 = SCNNode()
        
        ndV2.position = v2
        
        let ndZAlign = SCNNode()
        ndZAlign.eulerAngles.x = Float.pi/2
        
        let cylgeo = SCNBox(width: 0.02, height: height1, length: 0.001, chamferRadius: 0)
        cylgeo.materials = material
        
        let ndCylinder = SCNNode(geometry: cylgeo )
        ndCylinder.position.y = Float(-height1/2) + 0.001
        ndZAlign.addChildNode(ndCylinder)
        
        addChildNode(ndZAlign)
        
        constraints = [SCNLookAtConstraint(target: ndV2)]
    }
    
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func distanceBetweenPoints2(A: SCNVector3, B: SCNVector3) -> CGFloat {
        let l = sqrt(
            (A.x - B.x) * (A.x - B.x)
                +   (A.y - B.y) * (A.y - B.y)
                +   (A.z - B.z) * (A.z - B.z)
        )
        return CGFloat(l)
    }
}
extension UIImage {
    func drawtext(text:String,point:CGRect)->UIImage{
        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let bkc=CGMutablePath()
        bkc.addRect(point)
        let content=UIGraphicsGetCurrentContext()
        content?.addPath(bkc)
        content?.setLineWidth(point.height)
        content?.setStrokeColor(UIColor.white.cgColor)
        content?.strokePath()
        let newtext=NSString(string: text)
        newtext.draw(in: point, withAttributes: [NSAttributedString.Key.foregroundColor:UIColor.red,NSAttributedString.Key.font:UIFont.systemFont(ofSize: point.height-25)])
        let image=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    func ardrawtext(text:String,point:CGRect,fontsize:Int)->UIImage{
        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let bkc=CGMutablePath()
        bkc.addRect(point)
        let content=UIGraphicsGetCurrentContext()
        let newtext=NSString(string: text)
        newtext.draw(in: point, withAttributes: [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:UIFont.systemFont(ofSize: CGFloat(fontsize))])
        let image=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleToFill) {
        
        contentMode = mode
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // The download has finished.
            
            if let e = error {
                
                print("Error downloading cat picture: \(e)")
                
            } else {
                
                // No errors found.
                
                // It would be weird if we didn't have a response, so check for that too.
                
                if let res = response as? HTTPURLResponse {
                    
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    
                    if let imageData = data {
                        
                        // Finally convert that Data into an image and do what you wish with it.
                        
                        let image = UIImage(data: imageData)
                        
                        // Do something with your image.
                        
                        DispatchQueue.main.async() { () -> Void in
                            
                            self.image = image
                            
                        }
                        
                    } else {
                        
                        print("Couldn't get image: Image is nil")
                        
                    }
                    
                } else {
                    
                    print("Couldn't get response code for some reason")
                    
                }
                
            }
            
            }.resume()
        
    }
    
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        
        guard let url = URL(string: link) else { return }
        
        downloadedFrom(url: url, contentMode: mode)
        
    }
    
}

extension String {
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
    }
    func utf8encodedString() ->String {
        var arr = [UInt8]()
        arr += self.utf8
        return String(bytes: arr,encoding: String.Encoding.utf8)!
    }
}
extension UIImageView{
    func drawmao(rect:CGRect){
        let blurEffect = UIBlurEffect(style: .light)
        //创建一个承载模糊效果的视图
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = rect
        self.addSubview(blurView)
    }
    func screenShot() -> UIImage? {
        
        guard frame.size.height > 0 && frame.size.width > 0 else {
            
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    

}
extension UIView {
    func superView<T: UIView>(of: T.Type) -> T? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let father = view as? T {
                return father
            }
        }
        return nil
    }
}
public class Alltool: NSObject {
    public func md5(strs:String) ->String!{
        let str = strs.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(strs.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen { hash.appendFormat("%02x", result[i]) }
        result.deinitialize()
        return String(format: hash as String) }
    func getangel(latitude1:Double,longitude1:Double,latitude2:Double,longitude2:Double)->Double
    {
        var cos_c:Double = cos(90 - latitude2)*cos(90 - latitude1) + sin(90 - latitude2)*sin(90 - latitude1)*cos(longitude2-longitude1);
        
        var sin_c:Double = sqrt(1 - pow(cos_c, 2));
        
        var z:Double = asin(sin(90 - latitude2)*sin(longitude2 - longitude1)/sin_c);
        
        z = (z*180.0/M_PI)
        if(longitude1 < longitude2 && latitude1 < latitude2) { // 第一象限
            
        } else if (longitude1 < longitude2 && latitude1 > latitude2){ // 第二象限
            
            z += 360;
            
        } else { // 三四象限
            
            z = 180 - z;
            
        }
        
        return (z/180)*M_PI
    }
}
extension String{
    func deletexie()->String{
        var temp:String=self
        for (index,item) in temp.enumerated(){
            if item=="\\"{
                let ind:Index=Index(encodedOffset: index)
                temp.remove(at: ind)
                print(item)
            }
            }
        return temp
    }
}


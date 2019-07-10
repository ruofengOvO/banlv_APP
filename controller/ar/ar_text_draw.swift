//
//  ar_text_draw.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/17.
//  Copyright © 2019 Rohlf W. All rights reserved.
//


import UIKit
import SceneKit
import ARKit
import SwiftyJSON
extension arplaceViewController{
    func drawtextborder(rxt:CGRect,text:String){
        let mat = SCNMaterial()
        print(rxt)
        mat.diffuse.contents  = UIColor.green
        let maxl=scenlocview.worldVector(for: rxt.get_point_maxl())
        let maxr=scenlocview.worldVector(for: rxt.get_point_maxr())
        let minl=scenlocview.worldVector(for: rxt.get_point_minl())
        let minr=scenlocview.worldVector(for: rxt.get_point_minr())
        let textscen=SCNText(string: text, extrusionDepth: 1)
        textscen.materials=[mat]
        let textnode=SCNNode()
        textnode.position=maxl!
        var distancex=Float.maximum((maxr?.distance(vector: maxl!))!, (maxr?.distance(vector: minr!))!)/Float(20*text.count)
        var distancey=Float.minimum((maxr?.distance(vector: minr!))!, (maxr?.distance(vector: maxl!))!)/Float(20)
        textnode.scale=SCNVector3Make(
            distancex ,distancey , 0.001)
        textnode.geometry=textscen
        let ptrotation=scenlocview.pointOfView?.rotation
        textnode.rotation=SCNVector4((ptrotation?.x)!, (ptrotation?.y)!,(ptrotation?.z)!, (ptrotation?.w)!
        )
        scenlocview.scene.rootNode.addChildNode(textnode)
        scenlocview.scene.rootNode.addChildNode((maxl?.drawLine(vector: maxr!, color: UIColor.red))!)
        scenlocview.scene.rootNode.addChildNode((maxr?.drawLine(vector: minr!, color: UIColor.red))!)
        scenlocview.scene.rootNode.addChildNode((minr?.drawLine(vector: minl!, color: UIColor.red))!)
        scenlocview.scene.rootNode.addChildNode((minl?.drawLine(vector: maxl!, color: UIColor.red))!)
    }
    func draw(date:[loc])
    {
        var si:Int=OnehandMode.OnehandMode1()
        for (index,arrayitem)in date.enumerated(){
            self.drawtextborder(rxt: CGRect(x: arrayitem.left/si, y: arrayitem.top/si, width: arrayitem.width/si, height: arrayitem.heith/si), text: arrayitem.text)
        }
    }
    
}

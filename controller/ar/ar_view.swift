//
//  ar_view.swift
//  test2
//
//  Created by miaoz on 2019/2/20.
//  Copyright © 2019 miaoz. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SwiftyJSON
extension ar_ViewController{
    func drawtextborder(rxt:CGRect,text:String){
        let mat = SCNMaterial()
        print(rxt)
        mat.diffuse.contents  = UIColor.green
        let maxl=scenView.worldVector(for: rxt.get_point_maxl())
        let maxr=scenView.worldVector(for: rxt.get_point_maxr())
        let minl=scenView.worldVector(for: rxt.get_point_minl())
        let minr=scenView.worldVector(for: rxt.get_point_minr())
        let textscen=SCNText(string: text, extrusionDepth: 1)
        textscen.materials=[mat]
        let textnode=SCNNode()
        textnode.position=maxl!
        var distancex=Float.maximum((maxr?.distance(vector: maxl!))!, (maxr?.distance(vector: minr!))!)/Float(20*text.count)
        var distancey=Float.minimum((maxr?.distance(vector: minr!))!, (maxr?.distance(vector: maxl!))!)/Float(20)
        textnode.scale=SCNVector3Make(
           distancex ,distancey , 0.001)
        textnode.geometry=textscen
        let ptrotation=scenView.pointOfView?.rotation
        textnode.rotation=SCNVector4((ptrotation?.x)!, (ptrotation?.y)!,(ptrotation?.z)!, (ptrotation?.w)!
        )
        scenView.scene.rootNode.addChildNode(textnode)
        scenView.scene.rootNode.addChildNode((maxl?.drawLine(vector: maxr!, color: UIColor.red))!)
        scenView.scene.rootNode.addChildNode((maxr?.drawLine(vector: minr!, color: UIColor.red))!)
        scenView.scene.rootNode.addChildNode((minr?.drawLine(vector: minl!, color: UIColor.red))!)
        scenView.scene.rootNode.addChildNode((minl?.drawLine(vector: maxl!, color: UIColor.red))!)
       /*scenView.scene.rootNode.addChildNode(LineNode(v1: maxr!, v2: maxl!, material: [mat]))
       scenView.scene.rootNode.addChildNode(LineNode(v1: maxl!, v2: minl!, material: [mat]))
        scenView.scene.rootNode.addChildNode(LineNode(v1: minl!, v2: minr!, material: [mat]))
       scenView.scene.rootNode.addChildNode(LineNode(v1: minr!, v2: maxr!, material: [mat]))*/
    }
    func draw(date:[loc])
    {
        for (index,arrayitem)in date.enumerated(){
            self.drawtextborder(rxt: CGRect(x: arrayitem.left/2, y: arrayitem.top/2, width: arrayitem.width/2, height: arrayitem.heith/2), text: arrayitem.text)
        }
    }

}


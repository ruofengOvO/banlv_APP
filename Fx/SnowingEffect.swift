//
//  SnowingEffect.swift
//  UIView
//
//  Created by 韩梓健 on 2019/3/3.
//  Copyright © 2019 韩梓健. All rights reserved.
//

import UIKit

class SnowingEffect: NSObject {
    func StarSnow(view:UIView,Source:String){
    let rect = CGRect(x: 0.0, y: -70.0, width: view.bounds.width,
                      height: 50.0)
    let emitter = CAEmitterLayer()
    emitter.frame = rect
    view.layer.addSublayer(emitter)
        emitter.emitterShape = CAEmitterLayerEmitterShape.rectangle
    
    //kCAEmitterLayerPoint
    //kCAEmitterLayerLine
    //kCAEmitterLayerRectangle
    
    emitter.emitterPosition = CGPoint.init(x: rect.width/2, y: rect.height/2)
    emitter.emitterSize = rect.size
    
    let emitterCell = CAEmitterCell()
    emitterCell.contents = UIImage(named:Source)!.stretchableImage(withLeftCapWidth: 30, topCapHeight: 30).cgImage//要发射的源文件
    emitterCell.birthRate = 120  //每秒产生120个粒子
    emitterCell.lifetime = 3    //存活1秒
    emitterCell.lifetimeRange = 3.0
    
    emitter.emitterCells = [emitterCell]  //只发射一种粒子
    emitterCell.yAcceleration = 70.0  //给Y方向一个加速度
    //emitterCell.xAcceleration = 20.0 //x方向一个加速度
    emitterCell.velocity = 20.0 //初始速度
    emitterCell.emissionLongitude = CGFloat(-Double.pi) //向左
    emitterCell.velocityRange = 200.0   //随机速度 -200+20 --- 200+20
    emitterCell.emissionRange = CGFloat(Double.pi/2) //随机方向 -pi/2 --- pi/2
    //emitterCell.color = UIColor(red: 0.9, green: 1.0, blue: 1.0,
    //   alpha: 1.0).CGColor //指定颜色
    /*emitterCell.redRange = 0.3
    emitterCell.greenRange = 0.3
    emitterCell.blueRange = 0.3  //三个随机颜色
    */
    emitterCell.scale = 0.8
    emitterCell.scaleRange = 0.8  //0 - 1.6
    emitterCell.scaleSpeed = -0.15  //逐渐变小
    
    emitterCell.alphaRange = 0.75   //随机透明度
    emitterCell.alphaSpeed = -0.15  //逐渐消失
    
    }
}

//
//  tempViewController.swift
//  ZheDie
//
//  Created by Rohlf W on 2019/3/3.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import UIKit

class tempViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 标题
        let titles = ["关注", "推荐", "苏州", "视频", "热点", "新时代", "娱乐", "问答","图片","科技","懂车帝","体育","财经","军事","国际","段子","趣图","街拍","健康","数码","育儿","历史","小视频","其它"]
        
        //["🌭美食","🏖景点"]
        
        //样式
        let style = YCTitleStyle()
        //可以滚动
        style.isScrollEnable = true
        
        // 子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let sb=UIStoryboard(name: "Main", bundle: nil)
            let vc=sb.instantiateViewController(withIdentifier: "TableViewController")
            childVcs.append(vc)
        }
        let NavH:CGFloat = UIScreen.main.bounds.height == 812 ? 84 : 64
        // pageView的frame
        let pageFrame = CGRect(x: 0, y: NavH, width: view.bounds.width, height: view.bounds.height - 64)
        
        // 创建YCPageView,并且添加到控制器的view中
        let pageView = YCPageView(frame: pageFrame, titles: titles, childVcs: childVcs, parentVc: self, style : style)
        view.addSubview(pageView)
    }
    
}

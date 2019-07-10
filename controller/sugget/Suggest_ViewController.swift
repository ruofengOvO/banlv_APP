
import UIKit
var Effects = SnowingEffect()
class Suggest_ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //Effects.StarSnow(view: self.view, Source: "Rain")
        // 标题
        let titles =
        [" 美食 "," 景点 "," 酒店 "," 娱乐 "]
        var titless:[String] = []
        
        //样式
        //样式
        let style = YCTitleStyle()
        //可以滚动
        style.isScrollEnable = false
        //显示底部滚动条
        style.isShowBottomLine = true
        //进行缩放
        style.isNeedScale = true
        //显示遮盖
        style.isShowCover = true
        
        // 子控制器
        var childVcs = [UIViewController]()
        for index in 0..<titles.count {
            let sb=UIStoryboard(name: "Mqain", bundle: nil)
            let vc=sb.instantiateViewController(withIdentifier: "TableViewController") as! MainTableViewController
            vc.tag=index
                DispatchQueue.main.async {
                //    vc.loaddata()
                }
            titless.append(NSLocalizedString(titles[index], comment: titles[index]))
            childVcs.append(vc)
        }
        let NavH:CGFloat = UIScreen.main.bounds.height == 812 ? 84 : 64
        // pageView的frame
        var height1 = 44.0
        
        let pageFrame = CGRect(x: 0, y: 14, width: view.bounds.width, height: view.bounds.height - 64)
        
        // 创建YCPageView,并且添加到控制器的view中
        let pageView = YCPageView(frame: pageFrame, titles: titless, childVcs: childVcs, parentVc: self, style : style)
        view.addSubview(pageView)
    }
}

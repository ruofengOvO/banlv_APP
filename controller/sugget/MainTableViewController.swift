
import UIKit
import FoldingCell
import OHMySQL
import SwiftyJSON
class MainTableViewController: UITableViewController {
    var data:[articleInfo]=[]{
        didSet{
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
        }
    }
        //[articleInfo(articleID: "as", articleWriterID: "as", title: "iadsio", images: [UIImage(named: "总合成.png")!,UIImage(named: "总合成.png")!],text:"sughdiuasdhyiusdhyaiusadu")]
    let s1 = UIImage(named: "btn_link_fill@2x")
    let s2 = UIImage(named: "btn_link_line@2x")
    var tag=0
    enum Const {
        static let closeCellHeight: CGFloat = 179   //179
        static let openCellHeight: CGFloat = 550    //488
        static let rowsCount = 10
    }
    
    var cellHeights: [CGFloat] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
     //   loaddata()
        
        
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.separatorColor =
            UIColor(red: 230/255.0, green: 230/255.0, blue: 231/255.0, alpha: 1.0)
        tableView.backgroundColor =
            UIColor(red: 250/255.0, green: 250/255.0, blue: 251/255.0, alpha: 1.0)
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                self?.tableView.dg_stopLoading()
            })
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
    
    
        
        Thread.detachNewThreadSelector(#selector(self.loaddata),
                                       toTarget: self, with: nil)
    
        setup()
    }
deinit {
    tableView.dg_removePullToRefresh()
}
   @objc func loaddata()
    {
        var datat:[articleInfo]=[]
        print(tag)
        do{
        let consql=ConnectSQL()
        consql.Conected()
        let query = OHMySQLQueryRequestFactory.select(consql.tableName, condition: "type = \(self.tag)")
        let reaponse = try consql.context.executeQueryRequestAndFetchResult(query)
            print(reaponse)
            for (index,item) in reaponse.enumerated(){
                //let dict1=try JSON(data: item["articleText"] as! Data)
                //let dict2=try JSON(data: item["articleimage"] as! Data)
                let text = NSString(data: item["articleText"] as! Data, encoding: String.Encoding.utf8.rawValue)! as String
                print(text)
                let title =
                    //dict1.stringValue
                (item["title"] as! NSString) as! String
                let imageurl1 = (item["articleimage"] as! NSString) as! String
                let imageurl2 = (item["articleimage1"] as! NSString) as! String
                    //dict2.stringValue
                    //String(data: item["articleimage"] as! NSString, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
                datat.append(articleInfo(articleID: "007", articleWriterID: "007", title: title, images: [imageurl1,imageurl2], text: text))
            }
            self.data=datat
            consql.Closed()
        }catch{
            print(error)
        }
    }
    private func setup() {
        cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
        tableView.estimatedRowHeight = Const.closeCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        if #available(iOS 10.0, *) {
            let refresh=UIRefreshControl()
          //  tableView.refreshControl = refresh
            refresh.attributedTitle=NSAttributedString(string: "正在刷新...")
           // refresh.addTarget(tableView, action: #selector(loaddata), for: .valueChanged)
         // tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        }
    }
    
    @objc func refreshHandler() {
        Thread.detachNewThreadSelector(#selector(self.loaddata),
                                       toTarget: self, with: nil)
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            if #available(iOS 10.0, *) {
                self?.tableView.refreshControl?.endRefreshing()
            }
            self?.tableView.reloadData()
        })
    }
}

// MARK: - TableView

extension MainTableViewController {
    
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }
    
    override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as DemoCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        
        
        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        
        cell.number = indexPath.row
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
        let vieww = cell.viewWithTag(113) as! UIView
        let image1 = cell.viewWithTag(601) as!UIImageView
        let view1 = cell.viewWithTag(6000)as!UIView
        let Userimg = cell.viewWithTag(603)as!UIImageView
        let view2 = cell.viewWithTag(6100)as!UIView
        let textv = cell.viewWithTag(612)as!UITextView
        let image2 = cell.viewWithTag(611)as!UIImageView
        let view3 = cell.viewWithTag(112)as!UIView
        let view4 = cell.viewWithTag(8087)as!UIView
        let title=cell.viewWithTag(602)as! UILabel
        view1.layer.cornerRadius = 10
        view1.layer.masksToBounds = true
        view2.layer.cornerRadius = 10
        view2.layer.masksToBounds = true
        view3.layer.cornerRadius = 10
        view3.layer.masksToBounds = true
        view4.layer.cornerRadius = 10
        view4.layer.masksToBounds = true
        view4.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0.7)
        Userimg.layer.cornerRadius = 10
        Userimg.layer.masksToBounds = true
        image1.layer.cornerRadius = 10
        image1.layer.masksToBounds = true
        textv.layer.cornerRadius = 10
        textv.layer.masksToBounds = true
        image2.layer.cornerRadius = 10
        image2.layer.masksToBounds = true
        textv.isEditable = false
        let starView = LCStarView()
        starView.frame = CGRect(x:0, y:0, width:s1!.size.width, height:s1!.size.height)
        image1.downloadedFrom(link: self.data[indexPath.row].articleimage![0], contentMode: .scaleToFill)
        image2.downloadedFrom(link: self.data[indexPath.row].articleimage![1], contentMode: .scaleToFill)
        textv.text=self.data[indexPath.row].articleText!
        let newtext=NSString(string: textv.text)
        title.font = UIFont(name: "FZDESHS_506L--GB1-0", size: 19)
        //
        textv.font = UIFont(name: "FZDESHS_501L--GB1-0", size: 19)
        var random:Int = Int( indexPath.row % 2);
        Userimg.image=Lautype_Apikey_date().userimagedate[random]
        title.text=self.data[indexPath.row].title!
        //let constraintStar = NSLayoutConstraint.init(item:starView,attribute:NSLayoutConstraint.Attribute.right,relatedBy:NSLayoutConstraint.Relation.equal,toItem:nil,attribute: NSLayoutConstraint.Attribute.notAnAttribute,multiplier:1.0,constant: 8)
        //let constraintStar2 = NSLayoutConstraint.init(item:starView,attribute:NSLayoutConstraint.Attribute.bottom,relatedBy:NSLayoutConstraint.Relation.equal,toItem:nil,attribute: NSLayoutConstraint.Attribute.notAnAttribute,multiplier:1.0,constant: 8)
        
        //starView.addConstraint(constraintStar)
        //starView.addConstraint(constraintStar2)
        starView.maskImage = s1!
        starView.borderImage = s2!
        starView.fillColor = UIColor(red: 0.94, green: 0.27, blue: 0.32, alpha: 1)
        vieww.addSubview(starView)
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        
        return cell
    }
    
    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
}

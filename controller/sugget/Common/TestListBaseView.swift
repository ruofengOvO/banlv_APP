//
//  TestListView.swift
//  JXPagingView
//
//  Created by jiaxin on 2018/5/28.
//  Copyright © 2018年 jiaxin. All rights reserved.
//pod 'JXCategoryView'

import UIKit
import JXCategoryView
import JXPagingView
import MJRefresh


@objc public class TestListBaseView: UIView {
    @objc public var tableView: UITableView!
    @objc public var dataSource: [String]?
    @objc public var isNeedHeader = false {
        didSet {
            if isNeedHeader {
                self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
            }else if self.tableView.mj_header != nil {
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_header.removeFromSuperview()
                self.tableView.mj_header = nil
            }
        }
    }
    @objc public var isNeedFooter = false {
        didSet {
            if isNeedFooter {
                tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMore))
            }else if self.tableView.mj_footer != nil {
                self.tableView.mj_footer.endRefreshing()
                self.tableView.mj_footer.removeFromSuperview()
                self.tableView.mj_footer = nil
            }
        }
    }
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    var lastSelectedIndexPath: IndexPath?
    var isHeaderRefreshed = false

    deinit {
        listViewDidScrollCallback = nil
    }
    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView = UITableView(frame: frame, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TestTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        addSubview(tableView)
    }

    func beginFirstRefresh() {
        if !isHeaderRefreshed {
            if (self.isNeedHeader) {
                self.tableView.mj_header.beginRefreshing()
                headerRefresh()
            }else {
                self.isHeaderRefreshed = true
                self.tableView.reloadData()
            }
        }
    }

    @objc func headerRefresh() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(2)) {
            self.tableView.mj_header.endRefreshing()
            self.isHeaderRefreshed = true
            self.tableView.reloadData()
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        tableView.frame = self.bounds
    }

    @objc func loadMore() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(2)) {
            self.dataSource?.append("加载更多成功")
            self.tableView.reloadData()
            self.tableView.mj_footer.endRefreshing()
        }
    }

    func selectedCell(at indexPath: IndexPath) {
        if lastSelectedIndexPath == indexPath {
            return
        }
        if lastSelectedIndexPath != nil {
            let cell = tableView.cellForRow(at: lastSelectedIndexPath!)
            cell?.setSelected(false, animated: false)
        }
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(true, animated: false)
        lastSelectedIndexPath = indexPath
    }

}

extension TestListBaseView: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isHeaderRefreshed {
            return dataSource?.count ?? 0
        }
        return 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        //let cell1 = Suggestion_ViewController().temp_TableView.dequeueReusableCell(withIdentifier: "suggest_cell", for: indexPath) as TestTableViewCell
        tableView.register(UINib(nibName: "tempTableViewCell", bundle: nil), forCellReuseIdentifier: "mycell")
      // let cell1=cellview.cell!
      //  let lab=cell1.viewWithTag(1001) as! UILabel
       // lab.text="line:\(indexPath)"
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! TestTableViewCell
       //  cell.textLabel?.text = dataSource?[indexPath.row]//这里可以加载datesouce里面的s东西，datesouce可以放图片
        //let btn:UIButton = cell1.viewWithTag(1001) as! UIButton
        //btn.setTitle("123", for: .normal)
      
        let lab=cell.viewWithTag(1001) as! UILabel
        let imageview1=cell.viewWithTag(1002) as!UIImageView
        lab.text="line:\(indexPath):缪传鹏是天才"//这里写文字
        imageview1.image=UIImage(named: "5BDDC1965CF60B764D731570B56DF54C.jpg")////这里放图片
        cell.bgButtonClicked = {[weak self] in
            print("bgButtonClicked:\(indexPath):缪传鹏是天才")//这里写点击事件
            self?.selectedCell(at: indexPath)
        }
        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180//这里修改高度
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.listViewDidScrollCallback?(scrollView)
    }
}

extension TestListBaseView: JXPagingViewListViewDelegate {
    public func listView() -> UIView {
        return self
    }
    
    public func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }

    public func listScrollView() -> UIScrollView {
        return self.tableView
    }

    public func listDidDisappear() {
        print("listDidDisappear")
    }

    public func listDidAppear() {
        print("listDidAppear")
    }
}

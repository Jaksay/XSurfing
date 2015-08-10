//
//  ViewController.swift
//  XSurfing
//
//  Created by huixinming on 6/24/15.
//  Copyright (c) 2015 huixinming. All rights reserved.
//

//引入相关头文件
import UIKit
import Foundation

class ViewController: UITableViewController {
    //创建相关网站字典模型
    let baidu = ["百度":"http://www.baidu.com"]
    let sina = ["新浪":"http://sina.com"]
    let phoenix = ["凤凰网":"http://www.ifeng.com"]
    //用于存储需要显示的网站
    var webSites:NSMutableArray
    //选择的网址，默认是百度
    var webAddress:String = "http://www.baidu.com"
    //storyboard创建controller必须要实现的初始化方法，可以在此处给成员变量赋初值
    required init!(coder aDecoder: NSCoder!) {
        //把要显示的网站添加进来，有个疑问是：在该方法中super.init方法必须在初始化完子类的成员变量后才能调用
        webSites = [baidu,sina,phoenix]
        super.init(coder: aDecoder)
    }
    //覆盖父类的相关方法
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //设置该ViewController的title和根View的背景色
        self.navigationItem.title = "XSuring"
        self.view.backgroundColor = UIColor.redColor()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //覆盖UITableView的相关delegate方法
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //返回要显示的行数
        return webSites.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //设置cell的相关显示
        let cellIdentifier:String = "webCell"
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell
        var row = indexPath.row
        var item = webSites[row] as! NSDictionary
        var webName:NSArray = item.allKeys
        cell.textLabel?.text = webName[0] as? String
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var row = indexPath.row
        var item = webSites[row] as! NSDictionary
        var webName:NSArray = item.allKeys as NSArray
        webAddress = item.objectForKey(webName[0]) as! String
        //点击时跳转到“网页内容显示界面，showDetailWebContent是storyboard segue identifier”
        self.performSegueWithIdentifier("showDetailWebContent", sender: self)
    }
    //把选中的网站url传递给“网页内容显示controller”
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        var webViewController = segue.destinationViewController as! WebViewController
        webViewController.detailURL = webAddress
    }
}


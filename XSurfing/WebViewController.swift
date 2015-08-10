//
//  WebViewController.swift
//  XSurfing
//
//  Created by huixinming on 6/26/15.
//  Copyright (c) 2015 huixinming. All rights reserved.
//
import UIKit
import Foundation

class WebViewController: UIViewController,UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    var tipLabel:UILabel
    var loading:UIActivityIndicatorView
    //需要加在的url，默认是百度
    var detailURL:String = "http//www.baidu.com"
    var urlRequest:NSURLRequest?
    required init(coder aDecoder: NSCoder) {
        //初始化提示语和加载框
        tipLabel = UILabel(frame: CGRectMake(20, 100, 400, 200))
        loading = UIActivityIndicatorView(activityIndicatorStyle:.Gray)
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //构建url请求对象
        var url = NSURL(string: detailURL)
        urlRequest = NSURLRequest(URL: url!)
        webView.loadRequest(urlRequest!)
        //把webview的委托设为自己
        webView.delegate = self
        tipLabel.backgroundColor = UIColor.clearColor()
        tipLabel.numberOfLines = 0
        webView.scrollView.addSubview(loading)
        loading.center = webView.center
    }
    func webViewDidStartLoad(webView: UIWebView)
    {
        //开始加载网页时显示loading框
        loading.startAnimating()
    }
    func webViewDidFinishLoad(webView: UIWebView)
    {
        //当网页加载完成后，消失loading框和提示语
        loading.stopAnimating()
        tipLabel.removeFromSuperview()
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError)
    {
        //当网页加载失败时，消失loading框，显示提示语
        loading.stopAnimating()
        tipLabel.text = "ERROR!"
        view.addSubview(tipLabel)
    }
}
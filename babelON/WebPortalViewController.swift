//
//  WebPortalViewController.swift
//  babelON
//
//  Created by Connor Temple on 11/10/18.
//  Copyright © 2018 Quinn Huettner. All rights reserved.
//

import UIKit
import WebKit

class WebPortalViewController: UIViewController, WKNavigationDelegate {
	@IBOutlet weak var webView: WKWebView!
	@IBOutlet weak var progressView: UIProgressView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		self.progressView.isHidden = true
		self.webView.navigationDelegate = self
		self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
		self.webView.load(URLRequest(url: URL(string: "\(SITE_URL)/users/sign_up")!))
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func done(_ sender: Any) {
		self.parent?.dismiss(animated: true, completion: nil)
	}
	
	func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
		progressView.isHidden = false
		print(webView.url!.absoluteString)
		if webView.url?.absoluteString == "\(SITE_URL)/users/sign_in" {
			self.dismiss(animated: true, completion: nil)
		}
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		progressView.isHidden = true
		self.title = webView.title
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "estimatedProgress" {
			self.progressView.progress = Float(self.webView.estimatedProgress)
		}
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}

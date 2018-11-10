//
//  LoginViewController.swift
//  babelON
//
//  Created by Connor Temple on 11/10/18.
//  Copyright © 2018 Quinn Huettner. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet var email: UITextField!
	@IBOutlet var password: UITextField!
	
	@IBOutlet var loadingIndicator: UIActivityIndicatorView!
	
	private var initial: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		// Do any additional setup before the view apears.
	}
	
	@IBAction func triggerLogin(_ sender: Any) {
		self.loginFromView()
	}
	
	func loginFromView() {
		self.email.isEnabled = false
		self.password.isEnabled = false
		self.loadingIndicator.startAnimating()
		
		let username = self.email.text
		let password = self.password.text
		
		DispatchQueue.global(qos: .background).async {
			if login(username: username, password: password) {
				DispatchQueue.main.sync {
					self.dismiss(animated: true, completion: nil)
				}
				
			} else {
				DispatchQueue.main.async {
					self.email.isEnabled = true
					self.password.isEnabled = true
					self.loadingIndicator.stopAnimating()
//					self.invalidLabel.isHidden = false
				}
			}
		}
	}
}

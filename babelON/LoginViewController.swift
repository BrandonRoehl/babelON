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
	
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var onepasswordButton: UIButton!
	@IBOutlet weak var loginButton: UIButton!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var invalidLabel: UILabel!
	
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
		self.usernameTextField.isEnabled = false
		self.passwordTextField.isEnabled = false
		self.activityIndicator.startAnimating()
		let username = self.usernameTextField.text
		let password = self.passwordTextField.text
		DispatchQueue.global(qos: .background).async {
			if login(username: username, password: password) {
				DispatchQueue.main.sync {
					self.dismiss(animated: true, completion: nil)
				}
			} else {
				DispatchQueue.main.async {
					self.usernameTextField.isEnabled = true
					self.passwordTextField.isEnabled = true
					self.activityIndicator.stopAnimating()
					self.invalidLabel.isHidden = false
				}
			}
		}
	}
}

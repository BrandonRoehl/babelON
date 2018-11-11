//
//  Helpers.swift
//  babelON
//
//  Created by Connor Temple on 11/10/18.
//  Copyright © 2018 Quinn Huettner. All rights reserved.
//

import Foundation

func login(username: String?, password: String?) -> Bool {
	let url = URL(string: "https://127.0.0.1:3000/users/sign_in")!
	let semaphore = DispatchSemaphore(value: 0)
	var request = URLRequest(url: url)
	request.httpMethod = "POST"
	request.addValue("application/json", forHTTPHeaderField: "Content-Type")
	let params: [String: Any] = [
		"user": [
			"email": username,
			"password": password,
		],
		"commit": "darwin"
	]
	var loggedIn: Bool = false
	request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
	URLSession.shared.dataTask(with: request) { (data, response, error) in
		// Print the result
		if response != nil {
			loggedIn = (response!.url != url)
		} else {
			loggedIn = UserDefaults.standard.string(forKey: "username") != nil
		}
		semaphore.signal()
		}.resume()
	semaphore.wait()
	if loggedIn {
		UserDefaults.standard.set(username, forKey: "username")
		UserDefaults.standard.set(password, forKey: "password")
	} else {
		UserDefaults.standard.set(nil, forKey: "username")
		UserDefaults.standard.set(nil, forKey: "password")
	}
	return loggedIn
}

// Retrive JSON from a URL as a NSDictionary using the shared session
func retrieveJson(url: URL, session: URLSession) -> Any? {
	// init helper variables
	let semaphore = DispatchSemaphore(value: 0)
	var json: Any?
	// Use the default session to login it can login on safari
	session.dataTask(with: url) { (data, response, error) in
		// make sure data exists and is not nil
		if data != nil {
			do { // Read in the responce as JSON
				json = try JSONSerialization.jsonObject(with: data!, options: [])
			} catch {
				print(error)
			}
		}
		semaphore.signal()
		}.resume()
	// Wait for the URL to return
	semaphore.wait()
	// Return the json if it exists and does not have errors
	return json
}


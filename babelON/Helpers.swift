//
//  Helpers.swift
//  babelON
//
//  Created by Connor Temple on 11/10/18.
//  Copyright © 2018 Quinn Huettner. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let SITE_URL = "https://babelon-chat.com"

func login(username: String?, password: String?) -> Bool {
	let url = URL(string: "\(SITE_URL)/users/sign_in")!
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

func loadData() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let moc: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

    // create testing data
    let mainConv = Conversation(context: moc)

    let mainUser = User(context: moc)
    mainUser.firstName = "main"
    let otherUser = User(context: moc)
    otherUser.firstName = "test"

    mainConv.addToUsers([mainUser, otherUser])

    let msg = Message(context: moc)
    msg.content = "This is a test msg"
    msg.date = Date() as NSDate
    msg.sentUser = otherUser

    mainConv.addToMessages(msg)
}



//static func create() -> CoreImage {
//    let appDelegate = NSApp.delegate as! AppDelegate
//    let moc: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//    return CoreImage(context: moc)
//}
//func delete() {
//    let appDelegate = NSApp.delegate as! AppDelegate
//    let moc: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//    // Delete
//    moc.delete(self)
//}
//
//static func getImagesFrom(predicate: NSPredicate?) -> [CoreImage] {
//    var fetchResults: [CoreImage] = []
//    let appDelegate = NSApp.delegate as! AppDelegate
//    let moc: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//
//    let fetchRequest: NSFetchRequest<CoreImage> = CoreImage.fetchRequest()
//    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "index", ascending: true)]
//    fetchRequest.predicate = predicate
//
//    do {
//        fetchResults = try moc.fetch(fetchRequest)
//    } catch {
//        print("Error: Can't fetch \(fetchRequest)")
//    }
//    return fetchResults
//}

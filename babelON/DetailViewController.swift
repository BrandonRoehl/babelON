//
//  DetailViewController.swift
//  babelON
//
//  Created by Potato on 11/10/18.
//  Copyright © 2018 Quinn Huettner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    weak var conversation:Conversation?

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = conversation?.description
        configureView()
    }

    var detailItem: Conversation? {
        didSet {
            // Update the view.
            configureView()
            
        }
    }


}


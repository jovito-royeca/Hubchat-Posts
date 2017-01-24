//
//  ViewController.swift
//  Hubchat Posts
//
//  Created by Jovito Royeca on 23/01/2017.
//  Copyright © 2017 Jovito Royeca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Variables
    var tableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: UITableViewDataSource
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        return UITableViewCell(style: .default, reuseIdentifier: "Cell")
    }
}

// MARK: UITableViewDelegate
extension ViewController : UITableViewDelegate {
    
}

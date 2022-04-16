//
//  HomeViewController.swift
//  ScoreChecker
//
//  Created by Jin younkyum on 2022/04/11.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var semesterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

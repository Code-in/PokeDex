//
//  PersonDetailViewController.swift
//  iOSHallOfFame
//
//  Created by Pete Parks on 4/29/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {

    // MARK: Properties and Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cohortLabel: UILabel!
    @IBOutlet weak var interestsTableView: UITableView!
    var person: Person?  // Optional for incoming person data
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        interestsTableView.delegate = self
        interestsTableView.dataSource = self

    }
    
    // MARK: Methods
    func updateViews() {
        guard let person = person else { return}
        nameLabel.text = person.firstName + " " + person.lastName
        cohortLabel.text = person.cohort
    }
    
    // MARK: Actions
    @IBAction func createInterestButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func deletePersonButtonTapped(_ sender: UIButton) {
    }
}


extension PersonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Likes" : "Dislikes"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? person?.likes?.count ?? 0 : person?.dislikes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "interestCell", for: indexPath)
        
        let interestText = indexPath.section == 0 ? person?.likes?[indexPath.row].text : person?.dislikes?[indexPath.row].text
        cell.textLabel?.text = interestText
        
        return cell
    }
    
}

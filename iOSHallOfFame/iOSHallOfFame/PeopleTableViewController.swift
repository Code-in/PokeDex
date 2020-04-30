//
//  PeopleTableViewController.swift
//  iOSHallOfFame
//
//  Created by Pete Parks on 4/29/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    
    // MARK: Properties
    
    private var page = 0
    private var isLastPage = false

    override func viewDidLoad() {
        super.viewDidLoad()
        getPeople()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PersonController.shared.people.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)

        let person = PersonController.shared.people[indexPath.row]
        cell.textLabel?.text = person.firstName + " " + person.lastName
        cell.detailTextLabel?.text = person.cohort
        
        if indexPath.row == PersonController.shared.people.count - 1 {
            getPeople()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Identifier
        let person = PersonController.shared.people[indexPath.row]
        
        PersonController.shared.getPersonDetails(person: person) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let person):
                    guard let dstVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PersonDetailViewController") as? PersonDetailViewController else { return }
                    // object = sent
                    dstVC.person = person
                    
                    self.navigationController?.pushViewController(dstVC, animated: true)
                case .failure(let error):
                    //self.presentErrorToUser(LocalizedError: error)
                    print(error)
                }
            }
            
            // Destination
            
            // Object - Ready
            
            // - Sent
        }
    }
    
    // MARK: Methods
    func getPeople() {
        PersonController.shared.getPeople(page: page) { (result) in
            switch result {
            case .success(let people):
                self.tableView.reloadData()
                if people.isEmpty {
                    self.isLastPage = true
                } else {
                    self.page += 1
                }
            case .failure(let error):
                //self.presentErrorToUser(LocalizedError: error)
                print(error)
            }
        }
    }
    

    @IBAction func createPersonButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
  

}

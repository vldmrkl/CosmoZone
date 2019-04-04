//
//  TopUsersViewController.swift
//  CosmoZone
//
//  Created by Volodymyr Klymenko on 2019-04-03.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import UIKit
import CoreData

struct UserScore {
    var name: String
    var score: Int
}

class TopUsersViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var scores: [UserScore] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.backgroundColor = .clear

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Scores")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                let name = data.value(forKey: "name") as! String
                let score = data.value(forKey: "score") as! Int
                let userScore = UserScore(name: name, score: score)
                scores.append(userScore)
            }
        } catch{
            print("Couldn't fetch data :(")
        }
        scores.sort(by: { $0.score > $1.score })
        if scores.count > 10 {
            scores.removeLast(scores.count-10)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreTableCell")!
        let text = scores[indexPath.row].name + ": " + String(scores[indexPath.row].score)
        cell.textLabel?.text = text
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        cell.backgroundColor = .clear
        return cell
    }
}

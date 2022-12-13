//
//  TrackingViewController.swift
//  MAPD714_Final_BMICalculator
//
//  Created by Po Lam Wong on 12/12/2022.
//

import UIKit

class TrackingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var dataList: [BmiData] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllData()
    }
    
    func getAllData() {
        do {
            dataList = try context.fetch(BmiData.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! TrackingTableViewCell
        cell.set(date: dataList[indexPath.row].date!, weight: dataList[indexPath.row].weight, mode: dataList[indexPath.row].mode!, bmiScore: dataList[indexPath.row].bmiScore )
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func updateData(indexPath:IndexPath){
        var updateMessage = UIAlertController(title: "Error", message: "Please enter height and weight", preferredStyle: .alert)
        let update = UIAlertAction(title: "Update", style: .default, handler: {(action) -> Void in})
        updateMessage.addAction(update)
        self.present(updateMessage, animated: true, completion: nil)
    }

}

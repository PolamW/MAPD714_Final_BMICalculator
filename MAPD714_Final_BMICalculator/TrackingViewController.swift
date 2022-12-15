//
//  TrackingViewController.swift
//  MAPD714_Final_BMICalculator
//
//  Created by Po Lam Wong on 12/12/2022.
//

import UIKit

class TrackingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var Add: UIBarButtonItem!
    private var dataList: [BmiData] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        getAllData()
    }
    
//    @objc private func didTapAdd() {
//        let alert = UIAlertController(title: "New Data", message: "Enter new data", preferredStyle: .alert)
//        alert.addTextField(configurationHandler: nil)
//        alert.addAction(UIAlertAction(title: "Add", style: .cancel))
//
//    }
    
    @IBAction func AddData(_ sender: Any) {
//        var addMessage = UIAlertController(title: "New Data", message: "Please enter new data", preferredStyle: .alert)
//        let cancel = UIAlertAction(title: "Add", style: .default, handler: {(action) -> Void in})
//        addMessage.addAction(cancel)
//        addMessage.addTextField(configurationHandler: nil)
//        
//        self.present(addMessage, animated: true, completion: nil)
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
    
    
    //delete data from core data
    func deleteData(data: BmiData) {
        context.delete(data)
        do {
            try context.save()
            dataList = try
            context.fetch(BmiData.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            getAllData()
        }
        catch {
            
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _,_,completion in
            let data = self.dataList[indexPath.row]
            self.deleteData(data: data)
            completion(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    
    func updateData(data: BmiData, newWeight: Float){
        data.weight = newWeight
        do {
            try context.save()
        }
        catch {
            
        }
        
//        var updateMessage = UIAlertController(title: "Error", message: "Please enter height and weight", preferredStyle: .alert)
//        let update = UIAlertAction(title: "Update", style: .default, handler: {(action) -> Void in})
//        updateMessage.addAction(update)
//        self.present(updateMessage, animated: true, completion: nil)
    }

}

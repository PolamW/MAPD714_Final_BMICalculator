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
    
    //request for data from core data
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
//        cell.record(date: dataList[indexPath.row].date!, weight: dataList[indexPath.row].weight, mode: dataList[indexPath.row].mode!, bmiScore: dataList[indexPath.row].bmiScore)
        return cell
    }
    
    //left swipe to delete from tableview
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _,_,completion in
            let data = self.dataList[indexPath.row]
            self.deleteData(data: data)
            completion(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
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
            if(dataList.count <= 0) {
                self.performSegue(withIdentifier: "home", sender: data)
            }
            getAllData()
        }
        catch {
            print("error")
        }
    }
    
    //update data from core data
    func updateData(data: BmiData, newWeight: Float){
        data.weight = newWeight
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
            print("error")
        }
    }
    
    //right swipe to edit page
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") {_,_,completion in
            let data = self.dataList[indexPath.row]
            self.performSegue(withIdentifier: "Edit", sender: data)
            completion(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [editAction])
        return configuration
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //selected data
//        let data = self.dataList[indexPath.row]
//        //Create alert
//        var addMessage = UIAlertController(title: "New Data", message: "Please enter new weight", preferredStyle: .alert)
//        let update = UIAlertAction(title: "Update", style: .default, handler: {(action) -> Void in})
//        addMessage.addAction(update)
//        addMessage.addTextField{(newWeightTF) in newWeightTF.placeholder = "Enter your new weight"}
//
//        self.present(addMessage, animated: true, completion: nil)
//
//        let textfield = addMessage.textFields![0]
//        textfield.text = String(data.weight)
//        let Weight = Float(textfield.text!)!
//
//        self.updateData(data: data, newWeight: Weight)
//
//        data.weight = Float(Weight!)!
        
        //        let updateButton = UIAlertAction(title: "Update", style: .default) {(action) in
        //            let textfield = addMessage.textFields![0]
        //            let WeightString = textfield.text
        //            self.newWeight = Float(WeightString!)!
//    }

//        do {
//            try context.save()
//        }
//        catch {
//
//        }
//        getAllData()
//    }
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Edit") {
            let updateView = segue.destination as? UpdateViewController
            let data = sender as! BmiData
            updateView?.data = data
        }
    }
}

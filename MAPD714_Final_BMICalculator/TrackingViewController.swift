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
    var newWeight: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        getAllData()
    }
    
//    @objc private func didTapAdd() {
//        let alert = UIAlertController(title: "New Data", message: "Enter new data", preferredStyle: .alert)
//        alert.addTextField{(textField) in textField.text = "Enter your new weight"}
//        alert.addAction(UIAlertAction(title: "Add", style: .cancel))
//
//    }
    
    @IBAction func AddData(_ sender: Any) {
        var addMessage = UIAlertController(title: "New Data", message: "Please enter new weight", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Add", style: .default, handler: {(action) -> Void in})
        addMessage.addAction(cancel)
        addMessage.addTextField{(newWeightTF) in newWeightTF.placeholder = "Enter your new weight"}
        
        self.present(addMessage, animated: true, completion: nil)
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
    
    //update data from core data
    func updateData(data: BmiData){
        data.bmiScore = newWeight
        do {
            try context.save()
            getAllData()
        }
        catch {
            
        }
    }
    
    //right swipe to edit page
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") {_,_,completion in
            let data = self.dataList[indexPath.row]
            self.navigationController.
        }
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //selected data
//        let data = self.dataList[indexPath.row].weight
//        //Create alert
//        var addMessage = UIAlertController(title: "New Data", message: "Please enter new weight", preferredStyle: .alert)
//        let cancel = UIAlertAction(title: "Add", style: .default, handler: {(action) -> Void in})
//        addMessage.addAction(cancel)
//        addMessage.addTextField{(newWeightTF) in newWeightTF.placeholder = "Enter your new weight"}
//
//        self.present(addMessage, animated: true, completion: nil)
//
//        let textfield = addMessage.textFields![0]
//        textfield.text = String(data)
//
//        let updateButton = UIAlertAction(title: "Update", style: .default) {(action) in
//            let textfield = addMessage.textFields![0]
//            let WeightString = textfield.text
//            self.newWeight = Float(WeightString!)!
//
//        }
//
//        do {
//            try context.save()
//            getAllData()
//        }
//        catch {
//
//        }
//    }
        
//        var updateMessage = UIAlertController(title: "Error", message: "Please enter height and weight", preferredStyle: .alert)
//        let update = UIAlertAction(title: "Update", style: .default, handler: {(action) -> Void in})
//        updateMessage.addAction(update)
//        self.present(updateMessage, animated: true, completion: nil)
    

}

//
//  UpdateViewController.swift
//  MAPD714_Final_BMICalculator
//
//  Created by Po Lam Wong on 16/12/2022.
//  Student ID: 301258847
//

import UIKit

class UpdateViewController: UIViewController {
    var data: BmiData? = nil
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var newDateTF: UITextField!
    @IBOutlet weak var newHeightTF: UITextField!
    @IBOutlet weak var newWeightTF: UITextField!
    @IBOutlet weak var newScoreLabel: UILabel!
    @IBOutlet weak var newDescriptionLabel: UILabel!
    @IBOutlet weak var newModeControl: UISegmentedControl!
    @IBOutlet weak var circularProgressBar: CircularProgrssBar!
    @IBOutlet weak var HeightLabel: UILabel!
    @IBOutlet weak var WeightLabel: UILabel!
    
    var bmiScore: Float = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(data!.weight)
    
        if (data != nil) {
            newDateTF.text = data!.date?.formatted()
            newHeightTF.text = String(data!.height)
            newWeightTF.text = String(data!.weight)
            if data?.mode == "kg" {
                newModeControl.selectedSegmentIndex = 0
                HeightLabel.text = "Height(cm)"
                WeightLabel.text = "Weight(kg)"
            } else {
                newModeControl.selectedSegmentIndex = 1
                HeightLabel.text = "Height(in)"
                WeightLabel.text = "Weight(lb)"
            }
            print(newWeightTF.text!)
           
        }
    }
    
    @IBAction func ModeChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            HeightLabel.text = "Height(cm)"
            WeightLabel.text = "Weight(kg)"
            newHeightTF.placeholder = "Height(cm)"
            newWeightTF.placeholder = "Weight(kg)"
        case 1:
            HeightLabel.text = "Height(in)"
            WeightLabel.text = "Weight(lb)"
            newHeightTF.placeholder = "Height(in)"
            newWeightTF.placeholder = "Weight(lb)"
        default:
            HeightLabel.text = "Height(cm)"
            WeightLabel.text = "Weight(kg)"
            newHeightTF.placeholder = "Height(cm)"
            newWeightTF.placeholder = "Weight(kg)"
        }
        
    }
    
    //Action to calculate the new bmi score
    @IBAction func Calculate(_ sender: Any) {
        if newHeightTF.text == "" || newWeightTF.text == "" {
            let errorMessage = UIAlertController(title: "Error", message: "Please enter height and weight", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in})
            errorMessage.addAction(ok)
            self.present(errorMessage, animated: true, completion: nil)
            
        } else {
            if newModeControl.selectedSegmentIndex == 0 {
                
                let stringHeight = newHeightTF.text!
                let stringWeight = newWeightTF.text!
                if let height = Double(stringHeight),
                   let weight = Double(stringWeight) {
                    let bmiScore = weight/(height/100 * height/100)
                    newScoreLabel.text = String(format: "%.2f", bmiScore)
                        if bmiScore >= 40 {
                            newDescriptionLabel.text = "Obese Class III"
                            circularProgressBar.foregroundLayer.strokeEnd = 1
                            } else if bmiScore >= 35 && bmiScore < 40  {
                            newDescriptionLabel.text = "Obese Class II"
                            circularProgressBar.foregroundLayer.strokeEnd = 0.875
                            } else if bmiScore >= 30 && bmiScore < 35 {
                            newDescriptionLabel.text = "Obese Class I"
                            circularProgressBar.foregroundLayer.strokeEnd = 0.75
                            } else if bmiScore >= 25 && bmiScore < 30 {
                            newDescriptionLabel.text = "Overweight"
                            circularProgressBar.foregroundLayer.strokeEnd = 0.625
                            } else if bmiScore >= 18.5 && bmiScore < 25 {
                            newDescriptionLabel.text = "Normal"
                            circularProgressBar.foregroundLayer.strokeEnd = 0.5
                            } else if bmiScore >= 17 && bmiScore < 18.5 {
                            newDescriptionLabel.text = "Mild Thinness"
                            circularProgressBar.foregroundLayer.strokeEnd = 0.375
                            } else if bmiScore >= 16 && bmiScore < 17 {
                            newDescriptionLabel.text = "Moderate Thinness"
                            circularProgressBar.foregroundLayer.strokeEnd = 0.25
                            } else {
                            newDescriptionLabel.text = "Severe Thinness"
                            circularProgressBar.foregroundLayer.strokeEnd = 0.125
                            }
                                    }
                circularProgressBar.isHidden = false
                newScoreLabel.isHidden = false
                newDescriptionLabel.isHidden = false
                } else {
                    let stringHeight = newHeightTF.text!
                    let stringWeight = newWeightTF.text!
                    if let height = Double(stringHeight),
                       let weight = Double(stringWeight) {
                        let bmiScore = weight*703/(height * height)
                        newScoreLabel.text = String(format: "%.2f", bmiScore)
                        
                        if bmiScore >= 40 {
                            newDescriptionLabel.text = "Obese Class III"
                            circularProgressBar.foregroundLayer.strokeEnd = 1
                            } else if bmiScore >= 35 && bmiScore < 40  {
                            newDescriptionLabel.text = "Obese Class II"
                            circularProgressBar.foregroundLayer.strokeEnd = 0.875
                            } else if bmiScore >= 30 && bmiScore < 35 {
                            newDescriptionLabel.text = "Obese Class I"
                            circularProgressBar.foregroundLayer.strokeEnd = 0.75
                            } else if bmiScore >= 25 && bmiScore < 30 {
                            newDescriptionLabel.text = "Overweight"
                            circularProgressBar.foregroundLayer.strokeEnd = 0.625
                            } else if bmiScore >= 18.5 && bmiScore < 25 {
                            newDescriptionLabel.text = "Normal"
                            circularProgressBar.foregroundLayer.strokeEnd = 0.5
                            } else if bmiScore >= 17 && bmiScore < 18.5 {
                            newDescriptionLabel.text = "Mild Thinness"
                            circularProgressBar.foregroundLayer.strokeEnd = 0.375
                            } else if bmiScore >= 16 && bmiScore < 17 {
                            newDescriptionLabel.text = "Moderate Thinness"
                            circularProgressBar.foregroundLayer.strokeEnd = 0.25
                            } else {
                            newDescriptionLabel.text = "Severe Thinness"
                            circularProgressBar.foregroundLayer.strokeEnd = 0.125
                            }
                }
                    circularProgressBar.isHidden = false
                newScoreLabel.isHidden = false
                newDescriptionLabel.isHidden = false
                    }
                }
            }
    
    //Action to update the data
    @IBAction func Update(_ sender: UIButton) {
        updateData(data: data!)
            
    }
    
    //Update new data to the core data
    func updateData(data: BmiData) {
        data.date = Date()
        data.height = Float(newHeightTF.text!)!
        data.weight = Float(newWeightTF.text!)!
        data.bmiScore = Float(newScoreLabel.text!)!
        do{
            try context.save()
        } catch {
            print("Error!")
        }
    }
            
        }
    

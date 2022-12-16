//
//  UpdateViewController.swift
//  MAPD714_Final_BMICalculator
//
//  Created by Po Lam Wong on 16/12/2022.
//

import UIKit

class UpdateViewController: UIViewController {
    public var data: BmiData?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var newDateTF: UITextField!
    @IBOutlet weak var newHeightTF: UITextField!
    @IBOutlet weak var newWeightTF: UITextField!
    @IBOutlet weak var newScoreLabel: UILabel!
    @IBOutlet weak var newDescriptionLabel: UILabel!
    @IBOutlet weak var newModeControl: UISegmentedControl!
    var bmiScore: Float = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (data != nil) {
            newDateTF.text = data!.date!.formatted()
            newHeightTF.text = String(data!.height)
            newWeightTF.text = String(data!.weight)
            print(newWeightTF.text!)
        }
    }
    
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
                            } else if bmiScore >= 35 && bmiScore < 40  {
                            newDescriptionLabel.text = "Obese Class II"
                            } else if bmiScore >= 30 && bmiScore < 35 {
                            newDescriptionLabel.text = "Obese Class I"
                            } else if bmiScore >= 25 && bmiScore < 30 {
                            newDescriptionLabel.text = "Overweight"
                            } else if bmiScore >= 18.5 && bmiScore < 25 {
                            newDescriptionLabel.text = "Normal"
                            } else if bmiScore >= 17 && bmiScore < 18.5 {
                            newDescriptionLabel.text = "Mild Thinness"
                            } else if bmiScore >= 16 && bmiScore < 17 {
                            newDescriptionLabel.text = "Moderate Thinness"
                            } else {
                            newDescriptionLabel.text = "Severe Thinness"
                                        }
                                    }
                newScoreLabel.isHidden = false
                newDescriptionLabel.isHidden = false
//                updateData()
                } else {
                    let stringHeight = newHeightTF.text!
                    let stringWeight = newWeightTF.text!
                    if let height = Double(stringHeight),
                       let weight = Double(stringWeight) {
                        let bmiScore = weight*703/(height * height)
                        newScoreLabel.text = String(format: "%.2f", bmiScore)
                        
                                    if bmiScore >= 40 {
                        newDescriptionLabel.text = "Obese Class III"
                    } else if bmiScore >= 35 && bmiScore < 40  {
                        newDescriptionLabel.text = "Obese Class II"
                    } else if bmiScore >= 30 && bmiScore < 35 {
                        newDescriptionLabel.text = "Obese Class I"
                    } else if bmiScore >= 25 && bmiScore < 30 {
                        newDescriptionLabel.text = "Overweight"
                    } else if bmiScore >= 18.5 && bmiScore < 25 {
                        newDescriptionLabel.text = "Normal"
                    } else if bmiScore >= 17 && bmiScore < 18.5 {
                        newDescriptionLabel.text = "Mild Thinness"
                    } else if bmiScore >= 16 && bmiScore < 17 {
                        newDescriptionLabel.text = "Moderate Thinness"
                    } else {
                        newDescriptionLabel.text = "Severe Thinness"
                    }
                }
                newScoreLabel.isHidden = false
                newDescriptionLabel.isHidden = false
//                updateData()
                    }
                }
            }
    
    @IBAction func Update(_ sender: UIButton) {
        updateData(data: data!)
    }
    
    func updateData(data: BmiData) {
        data.height = Float(newHeightTF.text!)!
        data.weight = Float(newWeightTF.text!)!
        data.bmiScore = Float(newScoreLabel.text!)!
        
        do{
            try context.save()
        } catch {
            
        }
    }
    
            
            
        }
    

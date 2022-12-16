//
//  ViewController.swift
//  MAPD714_Final_BMICalculator
//
//  Created by Po Lam Wong on 11/12/2022.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var AgeTF: UITextField!
    @IBOutlet weak var GenderTF: UITextField!
    @IBOutlet weak var HeightTF: UITextField!
    @IBOutlet weak var WeightTF: UITextField!
    
    @IBOutlet weak var UnitControl: UISegmentedControl!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    @IBOutlet weak var circularProgress: CircularProgrssBar!
    
    
    var countBar: CGFloat = 0
    var bmiScore: Float = 0.0
    
    var result: BmiData?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func unitChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            HeightTF.placeholder = "Height(cm)"
            WeightTF.placeholder = "Weight(kg)"
        case 1:
            HeightTF.placeholder = "Height(in)"
            WeightTF.placeholder = "Weight(lb)"
        default:
            HeightTF.placeholder = "Height(cm)"
            WeightTF.placeholder = "Weight(kg)"
        }
    }
    
    @IBAction func SubmitPressed(_ sender: UIButton) {
        if HeightTF.text == "" || WeightTF.text == "" {
            let errorMessage = UIAlertController(title: "Error", message: "Please enter height and weight", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in})
            errorMessage.addAction(ok)
            self.present(errorMessage, animated: true, completion: nil)

        } else {
            if UnitControl.selectedSegmentIndex == 0 {
            
                let stringHeight = HeightTF.text!
                let stringWeight = WeightTF.text!
                if let height = Double(stringHeight),
                   let weight = Double(stringWeight) {
                    let bmiScore = weight/(height/100 * height/100)
                    ScoreLabel.text = String(format: "%.2f", bmiScore)
                    
                    if bmiScore >= 40 {
                        DescriptionLabel.text = "Obese Class III"
                        circularProgress.foregroundLayer.strokeEnd = 1
                    } else if bmiScore >= 35 && bmiScore < 40  {
                        DescriptionLabel.text = "Obese Class II"
                        circularProgress.foregroundLayer.strokeEnd = 0.875
                    } else if bmiScore >= 30 && bmiScore < 35 {
                        DescriptionLabel.text = "Obese Class I"
                        circularProgress.foregroundLayer.strokeEnd = 0.75
                    } else if bmiScore >= 25 && bmiScore < 30 {
                        DescriptionLabel.text = "Overweight"
                        circularProgress.foregroundLayer.strokeEnd = 0.625
                    } else if bmiScore >= 18.5 && bmiScore < 25 {
                        DescriptionLabel.text = "Normal"
                        circularProgress.foregroundLayer.strokeEnd = 0.5
                    } else if bmiScore >= 17 && bmiScore < 18.5 {
                        DescriptionLabel.text = "Mild Thinness"
                        circularProgress.foregroundLayer.strokeEnd = 0.375
                    } else if bmiScore >= 16 && bmiScore < 17 {
                        DescriptionLabel.text = "Moderate Thinness"
                        circularProgress.foregroundLayer.strokeEnd = 0.25
                    } else {
                        DescriptionLabel.text = "Severe Thinness"
                        circularProgress.foregroundLayer.strokeEnd = 0.125
                    }
                }
                circularProgress.isHidden = false
                DescriptionLabel.isHidden = false
                recordData()
            } else {
                let stringHeight = HeightTF.text!
                let stringWeight = WeightTF.text!
                if let height = Double(stringHeight),
                   let weight = Double(stringWeight) {
                    let bmiScore = weight*703/(height * height)
                    ScoreLabel.text = String(format: "%.2f", bmiScore)
                    
                    if bmiScore >= 40 {
                        DescriptionLabel.text = "Obese Class III"
                        circularProgress.foregroundLayer.strokeEnd = 1
                    } else if bmiScore >= 35 && bmiScore < 40  {
                        DescriptionLabel.text = "Obese Class II"
                        circularProgress.foregroundLayer.strokeEnd = 0.875
                    } else if bmiScore >= 30 && bmiScore < 35 {
                        DescriptionLabel.text = "Obese Class I"
                        circularProgress.foregroundLayer.strokeEnd = 0.75
                    } else if bmiScore >= 25 && bmiScore < 30 {
                        DescriptionLabel.text = "Overweight"
                        circularProgress.foregroundLayer.strokeEnd = 0.625
                    } else if bmiScore >= 18.5 && bmiScore < 25 {
                        DescriptionLabel.text = "Normal"
                        circularProgress.foregroundLayer.strokeEnd = 0.5
                    } else if bmiScore >= 17 && bmiScore < 18.5 {
                        DescriptionLabel.text = "Mild Thinness"
                        circularProgress.foregroundLayer.strokeEnd = 0.375
                    } else if bmiScore >= 16 && bmiScore < 17 {
                        DescriptionLabel.text = "Moderate Thinness"
                        circularProgress.foregroundLayer.strokeEnd = 0.25
                    } else {
                        DescriptionLabel.text = "Severe Thinness"
                        circularProgress.foregroundLayer.strokeEnd = 0.125
                    }
                }
                circularProgress.isHidden = false
                DescriptionLabel.isHidden = false
                recordData()
            }
            
        }
        //Store data in CoreData
        func recordData() {
            let newData = BmiData(context: context)
            newData.bmiScore = Float(ScoreLabel.text!)!
            newData.height = Float(HeightTF.text!)!
            newData.weight = Float(WeightTF.text!)!
            if UnitControl.selectedSegmentIndex == 0{
                newData.mode = "kg"
            } else {
                newData.mode = "lb"
            }
            newData.date = Date()
            do {
                try context.save()
            }
            catch {
                
            }
        }
    }
}

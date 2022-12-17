//
//  TrackingTableViewCell.swift
//  MAPD714_Final_BMICalculator
//
//  Created by Po Lam Wong on 12/12/2022.
//  Student ID: 301258847
//

import UIKit

class TrackingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var WeightLabel: UILabel!
    @IBOutlet weak var BmiScoreLabel: UILabel!
    
    func record(date: Date, weight: Float, mode: String, bmiScore: Float) {
        DateLabel.text = date.formatted()
        if (mode == "kg") {
            WeightLabel.text = String(weight) + "kg"}
        else {
            WeightLabel.text = String(weight) + "lb"}
        BmiScoreLabel.text = String(bmiScore)
    }
}

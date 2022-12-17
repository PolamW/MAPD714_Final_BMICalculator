//
//  BmiData+CoreDataProperties.swift
//  MAPD714_Final_BMICalculator
//
//  Created by Po Lam Wong on 12/12/2022.
//
//

import Foundation
import CoreData


extension BmiData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BmiData> {
        return NSFetchRequest<BmiData>(entityName: "BmiData")
    }

    @NSManaged public var bmiScore: Float
    @NSManaged public var date: Date?
    @NSManaged public var height: Float
    @NSManaged public var weight: Float
    @NSManaged public var mode: String?
    
}

extension BmiData : Identifiable {

}

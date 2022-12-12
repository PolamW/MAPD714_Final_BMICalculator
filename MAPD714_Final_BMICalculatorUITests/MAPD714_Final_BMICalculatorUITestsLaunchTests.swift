//
//  MAPD714_Final_BMICalculatorUITestsLaunchTests.swift
//  MAPD714_Final_BMICalculatorUITests
//
//  Created by Po Lam Wong on 11/12/2022.
//

import XCTest

final class MAPD714_Final_BMICalculatorUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

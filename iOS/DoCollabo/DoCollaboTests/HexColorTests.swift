//
//  HexColorTests.swift
//  DoCollaboTests
//
//  Created by Cory Kim on 2020/06/19.
//  Copyright © 2020 delma. All rights reserved.
//

import XCTest
@testable import DoCollabo

final class HexColorTests: XCTestCase {
    
    private let whiteHexString: String = "#ffffff"
    private let whiteColor: UIColor = UIColor.white

    func testColorToHexString() {
        let hexString = whiteColor.hexString
        XCTAssertTrue(hexString == whiteHexString)
    }
    
    func testHextStringToColor() {
        let color = UIColor(hexString: whiteHexString)
        XCTAssertTrue(color.hexString == whiteColor.hexString)
    }
    
    func testDarkColor() {
        let darkColors = [
            UIColor(displayP3Red: 0.4, green: 0.4, blue: 0.4, alpha: 1),
            UIColor(displayP3Red: 0.5, green: 0.4, blue: 0.5, alpha: 1),
            UIColor(displayP3Red: 0.6, green: 0.3, blue: 0.4, alpha: 1)]
        darkColors.forEach {
            XCTAssertTrue($0.isDark)
        }
    }
    
    func testLightColor() {
        let lightColors = [
            UIColor(displayP3Red: 0.5, green: 0.6, blue: 0.5, alpha: 1),
            UIColor(displayP3Red: 0.7, green: 0.5, blue: 0.5, alpha: 1),
            UIColor(displayP3Red: 0.8, green: 0.4, blue: 0.4, alpha: 1)]
        lightColors.forEach {
            XCTAssertTrue($0.isDark != true)
        }
    }
}

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
        let hexString = whiteColor.toHex()
        XCTAssertTrue(hexString == whiteHexString)
    }
    
    func testHextStringToColor() {
        let color = UIColor(hexString: whiteHexString)
        XCTAssertTrue(color.toHex() == whiteColor.toHex())
    }
    
    func testColorDarkness() {
        let darkColor = UIColor(displayP3Red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        XCTAssertTrue(darkColor.isDark)
        let lightColor = UIColor(displayP3Red: 0.5, green: 0.6, blue: 0.5, alpha: 1)
        XCTAssertTrue(lightColor.isDark != true)
    }
}

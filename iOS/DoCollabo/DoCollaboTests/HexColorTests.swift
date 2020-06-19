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
}

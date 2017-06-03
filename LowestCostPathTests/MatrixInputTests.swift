//
//  MatrixSampleTests.swift
//  LowestCostPath
//
//  Created by Karim Abdel-Malek on 06/02/17.
//  Copyright © 2017 NA. All rights reserved.
//

import XCTest
@testable import LowestCostPath

    //9 Sample Tests

class MatrixInputTests: XCTestCase {
    
    func testForSample1() {
        
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4";
        let expectedPath = [1,2,3,4,4,5]
        
        do {
            let processor = try MatrixProcessor(with: input)
            if let result = processor.processMatrix() {
                XCTAssertTrue(result.pathCompleted)
                XCTAssertTrue(result.cost == 16)
                XCTAssertTrue(result.path == expectedPath)
            }
        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    func testForSample2() {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 1 2 3";
        let expectedPath = [1,2,1,5,4,5]

        do {
            let processor = try MatrixProcessor(with: input)
            if let result = processor.processMatrix() {
                XCTAssertTrue(result.pathCompleted)
                XCTAssertTrue(result.cost == 11)
                XCTAssertTrue(result.path == expectedPath)
            }
        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    func testForSample3() {
        let input = "19 10 19 10 19\n21 23 20 19 12\n20 12 20 11 10";
        let expectedPath = [1,1,1]
    
        do {
            let processor = try MatrixProcessor(with: input)
            if let result = processor.processMatrix() {
                XCTAssertFalse(result.pathCompleted)
                XCTAssertTrue(result.cost == 48)
                XCTAssertTrue(result.path == expectedPath)
            }
        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    // Single Row
    func testForSample4() {
        let input = "5 8 5 3 5";
        let expectedPath = [1,1,1,1,1]

        do {
            let processor = try MatrixProcessor(with: input)
            if let result = processor.processMatrix() {
                XCTAssertTrue(result.pathCompleted)
                XCTAssertTrue(result.cost == 26)
                XCTAssertTrue(result.path == expectedPath)
            }
        }
        catch let error {
            XCTAssertNil(error)
        }
        
    }
    
    // Single Column
    func testForSample5() {
        let input = "5\n8\n5\n3\n5"
        let expectedPath = [4]
        
        do {
            let processor = try MatrixProcessor(with: input)
            if let result = processor.processMatrix() {
                XCTAssertTrue(result.pathCompleted)
                XCTAssertTrue(result.cost == 3)
                XCTAssertTrue(result.path == expectedPath)
            }
        }
        catch let error {
            XCTAssertNil(error)
        }
        
    }
    
    
    // Non numeric
    func testForSample6() {
        let input = "5 4 H\n8 M 7\n5 7 5"
        
        do {
            let processor = try MatrixProcessor(with: input)
            if let result = processor.processMatrix() {
                XCTAssertFalse(result.pathCompleted)
            }
        }
        catch let error {
            XCTAssertTrue(error.localizedDescription == "Invalid matrix")
        }
    }

    
    
   // No Input
    func testForSample7() {
        let input = ""
        
        do {
            let processor = try MatrixProcessor(with: input)
            if let result = processor.processMatrix() {
                XCTAssertFalse(result.pathCompleted)
            }
        }
        catch let error {
            XCTAssertTrue(error.localizedDescription == "No input")
        }
    }
    
   // First column >50
    func testForSample8() {
        let input = "69 10 19 10 19\n51 23 20 19 12\n60 12 20 11 10"
        let expectedPath:[Int] = []
        
        do {
            let processor = try MatrixProcessor(with: input)
            if let result = processor.processMatrix() {
                XCTAssertFalse(result.pathCompleted)
                XCTAssertTrue(result.cost == 0)
                XCTAssertTrue(result.path == expectedPath)
            }
        }
        catch let error {
            XCTAssertNil(error)
        }
        
        
    }
    
    //First cell >50
    func testForSample9() {
        let input = "60 3 3 6\n6 3 7 9\n5 6 8 3"
        let expectedPath:[Int] = [3,2,1,3]
        
        do {
            let processor = try MatrixProcessor(with: input)
            if let result = processor.processMatrix() {
                XCTAssertTrue(result.pathCompleted)
                XCTAssertTrue(result.cost == 14)
                XCTAssertTrue(result.path == expectedPath)
            }
        }
        catch let error {
            XCTAssertNil(error)
        }
        
    }
    
    //-ve values
    func testForSample10() {
        let input = "60 3 -5 9\n-5 2 4 10\n3 -2 6 10\n6 -1 -2 10"
        let expectedPath:[Int] = [2,3,4,1]
        
        do {
            let processor = try MatrixProcessor(with: input)
            if let result = processor.processMatrix() {
                XCTAssertTrue(result.pathCompleted)
                XCTAssertTrue(result.cost == 0)
                XCTAssertTrue(result.path == expectedPath)
            }
        }
        catch let error {
            XCTAssertNil(error)
        }
        
    }
    
    // 2*3 matrix
    func testForSample11() {
        let input = "51 51\n0 51\n51 51\n5 5"
        let expectedPath:[Int] = [4,4]
        
        do {
            let processor = try MatrixProcessor(with: input)
            if let result = processor.processMatrix() {
                XCTAssertTrue(result.pathCompleted)
                XCTAssertTrue(result.cost == 10)
                XCTAssertTrue(result.path == expectedPath)
            }
        }
        catch let error {
            XCTAssertNil(error)
        }
        
    }
    
    // 3*2 matrix
    func testForSample12() {
        let input = "51 51 51\n0 51 51\n51 51 51 \n5 5 51"
        let expectedPath:[Int] = [4,4]
        
        do {
            let processor = try MatrixProcessor(with: input)
            if let result = processor.processMatrix() {
                XCTAssertFalse(result.pathCompleted)
                XCTAssertTrue(result.cost == 10)
                XCTAssertTrue(result.path == expectedPath)
            }
        }
        catch let error {
            XCTAssertNil(error)
        }
        
    }
    
    // 20 columns matrix
    func testForSample13() {
        let input = "1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1\n2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2"
        let expectedPath:[Int] = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        
        do {
            let processor = try MatrixProcessor(with: input)
            if let result = processor.processMatrix() {
                XCTAssertTrue(result.pathCompleted)
                XCTAssertTrue(result.cost == 20)
                XCTAssertTrue(result.path == expectedPath)
            }
        }
        catch let error {
            XCTAssertNil(error)
        }
    }

}

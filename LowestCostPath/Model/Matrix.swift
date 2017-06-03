//
//  Matrix.swift
//  LowestCostPath
//
//  Created by Karim Abdel-Malek on 06/02/17.
//  Copyright © 2017 NA. All rights reserved.
//

import Foundation

// Matrix model
class Matrix {
    
    var numberOfColumns = 0
    var numberOfRows = 0
    var costValues: [[Int]]?
    
    init(listOfCostValues:[[Int]]) {
        costValues = listOfCostValues
        numberOfRows = costValues!.count
        
        if numberOfRows > 0{
            numberOfColumns = (costValues?.first?.count)!
        }
    }
    
}

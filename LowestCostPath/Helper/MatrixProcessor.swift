//
//  MatrixHandler.swift
//  LowestCostPath
//
//  Created by Karim Abdel-Malek on 06/02/17.
//  Copyright © 2017 NA. All rights reserved.
//

import Foundation


// Processes the matrix for least cost.
class MatrixProcessor {
    
    private var inputMatrix: Matrix!
    private var numOfColumns = 0
    private var numOfRows = 0
    private var columnsProcessed = 0;
    
    init(with values:String) throws {
        
        let result = MatrixParser.parse(values)
        
        switch result {
        case .success(let costValues):
            inputMatrix = Matrix(listOfCostValues: costValues as! [[Int]])
            numOfColumns = inputMatrix.numberOfColumns
            numOfRows = inputMatrix.numberOfRows
            break
            
        case .failure(let error):
            throw error
        }
        
    }
    
    // Matrix cell index value
    func valueForIndex(index:(row:Int,column:Int)) -> Int? {
        guard index.row > -1 ,index.column > -1, index.row < numOfRows , index.column < numOfColumns else {
            return nil
        }
        return inputMatrix.costValues![index.row][index.column]
    }
    
    // Check if matrix is traversed completly or not
    func processedTillEnd()->Bool {
        return columnsProcessed == numOfColumns
    }
    
    // Returns all the cell indicies (row,column) for given column.
    func cellIndiciesForColumn(column:Int) -> [(Int,Int)] {
        var columnIndex = [(Int,Int)]()
        for row in 0..<numOfRows {
            columnIndex.append((row,column))
        }
        return columnIndex
    }
    
    // Calculates the minimum costs for given cell Indicies
    func miniumumOfCellsFor(cellindices:([(Int,Int)])) -> (index:(row:Int,column:Int)? ,value:Int?){
        var cost:Int?
        var costIndex : (Int,Int)?
        
        var indicies = cellindices
        if(numOfRows==3){
            indicies = cellindices.reversed()
        }
        
        //Loop through the cell edges
        for cellIndex in indicies {
            if let cellCost = valueForIndex(index: cellIndex){
                if let minimumCost = cost {
                    if cellCost < minimumCost {
                        cost = cellCost
                        costIndex = cellIndex
                    }
                }
                else{
                    cost = cellCost
                    costIndex = cellIndex
                }
            }
        }
        return (costIndex,cost)
    }
    
    //MARK: Cost Calculation
    func processColumn(column:Int) -> ([Int],proceedNext:Bool){
        var columnCosts = [Int]()
        var proceedNext = true
        
        for currentRow in 0..<numOfRows {
            var currentIndexCost = valueForIndex(index: (currentRow,column))!
            if let cellEdges = neighbourCells(For: (currentRow,column)) {
                let minimumCellDetails = miniumumOfCellsFor(cellindices:cellEdges)
                let minimumEdgeCost = minimumCellDetails.value
                currentIndexCost = currentIndexCost + minimumEdgeCost!
            }
            columnCosts.append(currentIndexCost)
        }
        
        replaceColumnCosts(for: column, withcosts: columnCosts)
        
        let minimumColumnCost = minimumCostForColumn(column: column)
        if(minimumColumnCost.value! <= thresholdLimit) {
            columnsProcessed = columnsProcessed + 1
        } else {
            proceedNext = false
        }
        
        return (columnCosts, proceedNext)
    }
    
    // Internal function to replacecosts in particular column
    private func replaceColumnCosts(for column:Int , withcosts costs:[Int]) {
        for row in 0..<numOfRows {
            inputMatrix.costValues?[row][column] = costs[row]
        }
    }
    
    //MARK: Shortest Path
    func traceShortestPath() -> (path:[(Int,Int)],cost:Int,pathExists:Bool)? {
        
        guard inputMatrix.costValues != nil , columnsProcessed > 0 else{
            return nil
        }
        
        let lastColumnMinimumCostDetails = minimumCostForColumn(column: columnsProcessed-1)
        var currentIndex = lastColumnMinimumCostDetails.index!
        let minimumCost = lastColumnMinimumCostDetails.value
        
        var path = [(Int,Int)]()
        path.append(currentIndex)
        
        while currentIndex.column > 0 {
            let cells = neighbourCells(For: currentIndex)
            let minimumCellDetails = miniumumOfCellsFor(cellindices: cells!)
            currentIndex = minimumCellDetails.index!
            path.append(currentIndex)
        }
        
        path = path.reversed()
        let pathExists = processedTillEnd()
        return (path,minimumCost!,pathExists)
    }
    
    
    // Calculates the minimum cost for given column by checking for its adjacent cell edges.
    func minimumCostForColumn(column:Int) -> (index:(row:Int,column:Int)? ,value:Int?) {
        let columnIndicies = cellIndiciesForColumn(column: column)
        let minimumCostDetails = miniumumOfCellsFor(cellindices: columnIndicies)
        return minimumCostDetails
    }
    
    //MARK: Cell Edges
    func neighbourCells(For cellIndex:(row:Int,column:Int)) -> ([(Int,Int)]?)  {

        guard inputMatrix.costValues != nil , cellIndex.row > -1 ,cellIndex.column > 0 else {
            return nil
        }

        let straight = (cellIndex.row,cellIndex.column-1)
        
        var top = (cellIndex.row-1,cellIndex.column-1)
        if cellIndex.row == 0 {
            top = (numOfRows-1,cellIndex.column-1)
        }
        
        var bottom = (cellIndex.row+1,cellIndex.column-1)
        if cellIndex.row == numOfRows-1 {
            bottom = (0,cellIndex.column-1)
        }
        
        let adjacentCells = [top,straight,bottom]
        return adjacentCells
    }
    
    //Calculates Minimum cost
    func processMatrix()->(path:[Int],cost:Int,pathCompleted:Bool)?{
        
        //Return if matrix or values are nil
        guard inputMatrix != nil, inputMatrix!.costValues != nil else{
            return nil
        }
        
        for currentColumn in 0..<inputMatrix!.numberOfColumns{
            let columnCosts = processColumn(column: currentColumn)
            if columnCosts.proceedNext == false {
                break
            }
        }
        
        //Traces the minimum path on the processed Matrix
        if let minimumCostDetails = traceShortestPath() {
            let paths = minimumCostDetails.path
            var rowDetails = [Int]()
            for path in paths {
                rowDetails.append(path.0+1)
            }
            return(rowDetails,minimumCostDetails.cost,minimumCostDetails.pathExists)
        }
        
        //nil matrix
        return([],0,false)
    }
    
    
}


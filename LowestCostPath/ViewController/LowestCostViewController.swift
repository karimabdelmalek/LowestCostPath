//
//  CostDetailsViewController.swift
//  LowestCostPath
//
//  Created by Karim Abdel-Malek on 06/02/17.
//  Copyright © 2017 NA. All rights reserved.
//

import UIKit

class LowestCostViewController: UIViewController {
    
    @IBOutlet weak var leastCostPath: UILabel!
    @IBOutlet weak var leastCost: UILabel!
    @IBOutlet weak var pathExists: UILabel!
    @IBOutlet weak var costInputsView: UITextView!
    
    var userInput = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        costInputsView.text = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4";
    }
    
    
    @IBAction func submit(_ sender: Any) {
        
        costInputsView .resignFirstResponder()
        userInput = costInputsView.text;

        do {
            let processor = try MatrixProcessor(with: userInput)
            if let result = processor.processMatrix() {
                pathExists.text = "Path Exists: " + (result.pathCompleted ? "Yes":"No")
                leastCost.text = "Total Cost: " +  "\(result.cost)"
                leastCostPath.text = "Path: " + "\(result.path)"
            }
        }
        catch let error {
            pathExists.text = error.localizedDescription
            leastCost.text = ""
            leastCostPath.text = ""
            
        }
    }
    
}

//
//  ViewController.swift
//  test-logic
//
//  Created by Dmytro Ostapchenko on 08.09.2023.
//

import UIKit

class ViewController: UIViewController {
    private let logic: ViewControllerLogic
    private var output: ViewControllerLogic.Output
    
    init(logic: ViewControllerLogic) {
        self.logic = logic
        self.output = logic.getOutput(input: .init(startLoading: {
            
        }, stopLoading: {
            
        }, displayData: {
            
        }))
        
        
    }
    
    @objc func button1DidTap() {
        output.button1DidTap()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

//
//  Logic1.swift
//  test-logic
//
//  Created by Dmytro Ostapchenko on 09.09.2023.
//

import Foundation

class ViewControllerLogic {
    struct Input {
        let startLoading: () -> Void
        let stopLoading: () -> Void
        let displayData: (Int) -> Void
    }
    
    struct Output {
        let button1DidTap: () -> Void
        let textFieldDidChangeValue: (String) -> Void
    }
    
    var input: Input!
    
    func getOutput(input: Input) -> Output {
        self.input = input
        return Output(
            button1DidTap: {
                
            },
            textFieldDidChangeValue: { value in
                
            }
        )
    }
}

class ViewControllerLogic_Realization1: ViewControllerLogic {
    
    private func getData() -> Int {
        
    }

    override func getOutput(input: Input) -> ViewControllerLogic.Output {
        super.getOutput(input: input)
        return Output(
            button1DidTap: {
                self.input.startLoading()
                let data = self.getData()
                self.input.stopLoading()
                self.input.displayData(data)
            },
            textFieldDidChangeValue: {
                value in
                
            }
        )
    }
}

class ViewControllerLogic_Realization2: ViewControllerLogic {
    
    private func getData() -> Int {
        return 10
    }

    override func getOutput(input: Input) -> ViewControllerLogic.Output {
        super.getOutput(input: input)
        return Output(
            button1DidTap: {
                self.input.startLoading()
                let data = self.getData()
                self.input.stopLoading()
                self.input.displayData(data)
            },
            textFieldDidChangeValue: {
                value in
                
            }
        )
    }
}

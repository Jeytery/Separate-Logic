//
//  File.swift
//  test-logic
//
//  Created by Dmytro Ostapchenko on 09.09.2023.
//

import Foundation
import UIKit

struct FacadeModule<LogicType, ViewType> {
    let logic: LogicType
    let view: ViewType
}

struct ExampleModuleInput {
    var startLoading: () -> Void
    var stopLoading: () -> Void
    var displayData: (Int) -> Void
}

struct ExampleModuleOutput {
    var button1DidTap: () -> Void
}

class ExampleViewController: UIViewController {
    func startLoading() {}
    func stopLoading() {}
    func displayData(_ data: Int) {}
    
    var output: ExampleModuleOutput?
}

class ExampleModuleLogic: UIViewController {
    func transform(input: ExampleModuleInput) -> ExampleModuleOutput {
        return ExampleModuleOutput(button1DidTap: {})
    }
}

func ExampleModule() -> FacadeModule {
    let logic = ExampleModuleLogic()
    let view = ExampleViewController()
    let output = logic.transform(input: .init(startLoading: view.startLoading, stopLoading: view.stopLoading, displayData: view.displayData))
    view.output = output
    return FacadeModule(logic: logic, view: view)
}

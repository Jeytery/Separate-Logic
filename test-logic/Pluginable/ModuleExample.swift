//
//  ModuleExample.swift
//  test-logic
//
//  Created by Dmytro Ostapchenko on 10.09.2023.
//

import Foundation
import UIKit

struct PluginableExampleLogicInput {
    let startLoading: () -> Void
}

struct PluginableExampleLogicOuput {
    let button1DidTap: () -> Void
}

class KeyboardPlugin: Pluginable {
    var keyboardDidShow: ((Int) -> Void)?
    var keyboardDidHide: (() -> Void)?
   
    init() {
        
    }
}
 
class ManageExamplePlugin: Pluginable {
    var startLoading: (() -> Void)?
    var installData: ((Int) -> Void)?
    
    init() {
        
    }
    
    func getData() -> Int {
        
    }
    
    func viewDidAppear() {
        startLoading()
        installData(getData())
    }
}
 
class PluginableExampleLogicPlugin: FacadePlugin {
    private var input: PluginableExampleLogicInput!
    
    private weak var keyboardPlugin: KeyboardPlugin!
    private weak var manageExamplePlugin: ManageExamplePlugin!
    
    init() {
        keyboardPlugin = KeyboardPlugin()
        manageExamplePlugin = ManageExamplePlugin()
        super.init(plugins: [keyboardPlugin, manageExamplePlugin])
    }
    
    func transform(input: PluginableExampleLogicInput) -> PluginableExampleLogicOuput {
        self.input = input
        keyboardPlugin.keyboardDidShow = {
            value in
            input.startLoading()
        }
        manageExamplePlugin.installData = {
            print($0)
        }
        manageExamplePlugin.startLoading = input.startLoading
        return PluginableExampleLogicOuput(button1DidTap: {
            
        })
    }
    
    func viewDidLoad() {
        super.viewDidLoad()
        input.startLoading()
    }
}

// MARK: - usage variant 1
class PluginableExampleViewController_variant1: PluginableViewController {
    private var output: PluginableExampleLogicOuput?
    
    init(data: Int) {
        let logicPlugin = PluginableExampleLogicPlugin()
        self.output = logicPlugin.transform(input: .init(startLoading: startLoading))
        super.init(plugins: [logicPlugin])
    }
    
    private func startLoading() {}
}

// MARK: - usage variant 2
class PluginableExampleViewController_variant2: PluginableViewController {
    var output: PluginableExampleLogicOuput?
    
    init(data: Int, plugins: [Pluginable]) {
        super.init(plugins: plugins)
    }
    
    func startLoading() {}
}

func PluginableExampleModule(data: Int) -> PluginableExampleViewController_variant2 {
    let logicPlugin = PluginableExampleLogicPlugin()
    let view = PluginableExampleViewController_variant2(data: data, plugins: logicPlugin)
    view.output = logicPlugin.transform(input: .init(startLoading: view.startLoading))
    return view
}

//
//  PluginableViewController.swift
//  test-logic
//
//  Created by Dmytro Ostapchenko on 09.09.2023.
//

import Foundation
import UIKit

protocol Pluginable {
    func viewDidLoad()
    func viewDidAppear()
    func viewDidLoadEverything()
}

extension Pluginable {
    func viewDidLoad() {}
    func viewDidAppear() {}
    func viewDidLoadEverything() {}
}

class FacadePlugin: Pluginable {
    private var plugins: [Pluginable]
    
    init(plugins: [Pluginable]) {
        self.plugins = plugins
    }

    func viewDidLoad() {
        plugins.forEach {
            $0.viewDidLoad()
        }
    }
    
    func viewDidAppear() {
        plugins.forEach {
            $0.viewDidLoad()
        }
    }
    
    func viewDidLoadEverything() {
        plugins.forEach {
            $0.viewDidLoadEverything()
        }
    }
}

class PluginableViewController: UIViewController {
    private var isEverythingLoaded = false
    private var plugins: [Pluginable]
    
    init(plugins: [Pluginable]) {
        self.plugins = plugins
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plugins.forEach {
            $0.viewDidLoad()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        plugins.forEach {
            $0.viewDidAppear()
        }
        
        if !isEverythingLoaded {
            isEverythingLoaded = true
            plugins.forEach {
                $0.viewDidLoadEverything()
            }
        }
    }
    
    func addPlugin(_ plugin: Pluginable) {
        self.plugins.append(plugin)
    }
    
    func removePlugin(_ plugin: Pluginable) {
        self.plugins.filter({
            $0 === plugin
        })
    }
    
    func removePlugin(at index: Int) {
        self.plugins.remove(at: index)
    }
}

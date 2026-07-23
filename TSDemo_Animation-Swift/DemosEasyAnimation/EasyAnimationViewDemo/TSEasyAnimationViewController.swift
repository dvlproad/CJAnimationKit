//
//  TSEasyAnimationViewController.swift
//  CJAnimationKitDemo
//
//  Created by qian on 2025/1/11.
//  Copyright © 2025 dvlproad. All rights reserved.
//

import UIKit
import SwiftUI

@objc class TSEasyAnimationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建一个UIHostingController并传入ContentView
        let contentView = TSEasyAnimationView()
        let hostingController = UIHostingController(rootView: contentView)
        
        // 将hostingController添加为子视图控制器
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        // 设置hostingController的视图的布局约束
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}




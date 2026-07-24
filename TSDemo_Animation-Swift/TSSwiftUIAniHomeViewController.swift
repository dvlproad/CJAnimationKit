//
//  TSSwiftUIAniHomeViewController.swift
//  TSDemo_Animation-Swift
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

import UIKit
import CQDemoKit_Swift
import TSDemo_Animation

@objc class TSSwiftUIAniHomeViewController: CJUIKitBaseHomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("SwiftUI", comment: "")

        let sectionDataModels = NSMutableArray()

        // 视图常见动画
        do {
            let sectionDataModel = CQDMSectionDataModel()
            sectionDataModel.theme = "SwiftUI动画"
            do {
                let module = CQDMModuleModel()
                module.title = "普通图片的动画(SwiftUI)"
                module.content = " 弹跳bounce\n 缩放scale(缺)\n 摇摆wiggle/swing\n 旋转rotate\n 呼吸breathe\n 脉冲pulse"
                module.viewControllerGetterHandle = {
                    return TSNormalImageAnimationView().cqts_asUIViewController()
                }
                sectionDataModel.values.add(module)
            }
            do {
                let module = CQDMModuleModel()
                module.title = "Symbol图片的动画(SwiftUI且iOS18+)"
                module.content = " 弹跳bounce\n 缩放scale\n 摇摆wiggle\n 旋转rotate\n 呼吸breathe\n 脉冲pulse"
                module.viewControllerGetterHandle = {
                    if #available(iOS 18.0, *) {
                        return TSSymbolImageAnimationView().cqts_asUIViewController()
                    } else {
                        return UIViewController.init()
                    }
                }
                sectionDataModel.values.add(module)
            }
            sectionDataModels.add(sectionDataModel)
        }

        self.sectionDataModels = sectionDataModels
    }
}

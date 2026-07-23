//
//  QuartzCoreHomeViewController.swift
//  TSDemo_Animation-Swift
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

import UIKit
import CQDemoKit

@objc class QuartzCoreHomeViewController: CJUIKitBaseHomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("Home首页", comment: "")

        let sectionDataModels = NSMutableArray()

        // 视图常见动画
        do {
            let sectionDataModel = CQDMSectionDataModel()
            sectionDataModel.theme = "视图常见动画"
            do {
                let module = CQDMModuleModel()
                module.title = "弹跳 摆动 旋转 呼吸 脉冲(UIKit)"
                module.classEntry = TSEasyAnimationViewController.self
                sectionDataModel.values.add(module)
            }
            sectionDataModels.add(sectionDataModel)
        }

        // 视图抖动动画
        do {
            let sectionDataModel = CQDMSectionDataModel()
            sectionDataModel.theme = "视图抖动动画"
            do {
                let module = CQDMModuleModel()
                module.title = "视图抖动动画"
                module.classEntry = NSClassFromString("TSDemo_Animation.TSShakeViewController")
                sectionDataModel.values.add(module)
            }
            sectionDataModels.add(sectionDataModel)
        }

        // CALayer
        do {
            let sectionDataModel = CQDMSectionDataModel()
            sectionDataModel.theme = "CALayer"
            do {
                // RadarAnimation
                let radarAnimationModule = CQDMModuleModel()
                radarAnimationModule.title = "RadarAnimation(雷达动画)"
                radarAnimationModule.classEntry = NSClassFromString("TSDemo_Animation.RadarAnimationViewController")
                sectionDataModel.values.add(radarAnimationModule)

                // PeiwoAnimation
                let peiwoAnimationModule = CQDMModuleModel()
                peiwoAnimationModule.title = "PeiwoAnimation(陪我动画)"
                peiwoAnimationModule.classEntry = NSClassFromString("TSDemo_Animation.PeiwoAnimationViewController")
                sectionDataModel.values.add(peiwoAnimationModule)

                // ShimmerAnimationViewController
                let shimmerAnimationModule = CQDMModuleModel()
                shimmerAnimationModule.title = "shimmerAnimation(闪光动画)"
                shimmerAnimationModule.classEntry = NSClassFromString("TSDemo_Animation.ShimmerAnimationViewController")
                sectionDataModel.values.add(shimmerAnimationModule)

                // SampleLayerMaskViewController
                let sampleLayerMaskModule = CQDMModuleModel()
                sampleLayerMaskModule.title = "切出你心中的那个图案"
                sampleLayerMaskModule.classEntry = NSClassFromString("TSDemo_Animation.SampleLayerMaskViewController")
                sectionDataModel.values.add(sampleLayerMaskModule)
            }
            sectionDataModels.add(sectionDataModel)
        }

        self.sectionDataModels = sectionDataModels
    }
}

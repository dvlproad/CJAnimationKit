//
//  QuartzCoreHomeViewController.swift
//  TSDemo_Animation-Swift
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

import UIKit
import CQDemoKit
import TSDemo_Animation

@objc class QuartzCoreHomeViewController: CJUIKitBaseHomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("组件特效", comment: "")

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
                module.content = "UIView+CJShake"
                module.classEntry = TSShakeViewController.self
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
                radarAnimationModule.content = "UIControl+CJRadarAnimation"
                radarAnimationModule.classEntry = RadarAnimationViewController.self
                sectionDataModel.values.add(radarAnimationModule)
            }
            do {
                // PeiwoAnimation
                let peiwoAnimationModule = CQDMModuleModel()
                peiwoAnimationModule.title = "PeiwoAnimation(陪我动画)"
                peiwoAnimationModule.content = "UIView+CJZoomFrame"
                peiwoAnimationModule.classEntry = PeiwoAnimationViewController.self
                peiwoAnimationModule.isCreateByXib = true
                peiwoAnimationModule.xibBundle = Bundle(for: PeiwoAnimationViewController.self)
                sectionDataModel.values.add(peiwoAnimationModule)
            }
            do {
                // ShimmerAnimationViewController
                let shimmerAnimationModule = CQDMModuleModel()
                shimmerAnimationModule.title = "shimmerAnimation(闪光动画)"
                shimmerAnimationModule.classEntry = ShimmerAnimationViewController.self
                shimmerAnimationModule.isCreateByXib = true
                shimmerAnimationModule.xibBundle = Bundle(for: ShimmerAnimationViewController.self)
                sectionDataModel.values.add(shimmerAnimationModule)
            }
            do {
                // SampleLayerMaskViewController
                let sampleLayerMaskModule = CQDMModuleModel()
                sampleLayerMaskModule.title = "切出你心中的那个图案"
                sampleLayerMaskModule.classEntry = SampleLayerMaskViewController.self
                sampleLayerMaskModule.isCreateByXib = true
                sampleLayerMaskModule.xibBundle = Bundle(for: SampleLayerMaskViewController.self)
                sectionDataModel.values.add(sampleLayerMaskModule)
            }
            sectionDataModels.add(sectionDataModel)
        }

        self.sectionDataModels = sectionDataModels
    }
}

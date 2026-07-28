//
//  TSComponentAniHomeViewController.swift
//  TSDemo_Animation
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

import UIKit
import CQDemoKit
import TSDemo_Animation

class TSComponentAniHomeViewController: CJUIKitBaseHomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("组件特效", comment: "")

        let sectionDataModels = NSMutableArray()

        // 视图抖动动画
        do {
            let sectionDataModel = CQDMSectionDataModel()
            sectionDataModel.theme = "视图抖动动画"
            do {
                let module = CQDMModuleModel()
                module.title = "视图抖动动画"
                module.content = [
                    "UIView+CJShake",
                ].joined(separator: "\n")
                module.classEntry = TSShakeViewController.self
                sectionDataModel.values.add(module)
            }
            sectionDataModels.add(sectionDataModel)
        }
        
        // 视图加载动画
        do {
            let sectionDataModel = CQDMSectionDataModel()
            sectionDataModel.theme = "视图加载动画"
            do {
                let module = CQDMModuleModel()
                module.title = "视图加载动画"
                module.content = [
                    "layer 的 addSublayer 等于 CAShapeLayer : CALayer"
                ].joined(separator: "\n")
                module.classEntry = RefreshHomeViewController.self
                sectionDataModel.values.add(module)
            }
            sectionDataModels.add(sectionDataModel)
        }
        
        // 切图
        do {
            let sectionDataModel = CQDMSectionDataModel()
            sectionDataModel.theme = "切图"

            let module = CQDMModuleModel()
            module.title = "切出你心中的那个图案"
            module.classEntry = SampleLayerMaskViewController.self
            sectionDataModel.values.add(module)

            sectionDataModels.add(sectionDataModel)
        }

        // GradientCycleModule
        do {
            let sectionDataModel = CQDMSectionDataModel()
            sectionDataModel.theme = "GradientCycleModule"

            let module1 = CQDMModuleModel()
            module1.title = "圆形渐变旋转圆环"
            module1.classEntry = GradientCycleViewController.self
            sectionDataModel.values.add(module1)

            let module2 = CQDMModuleModel()
            module2.title = "圆形渐变旋转圆环(事例)"
            module2.content = ["进入支付的时钟倒计时页面"].joined(separator: "\n")
            module2.actionBlock = { [weak self] in
                TSPayCountDownUtil.presentPayCountDown(from: self)
            }
            sectionDataModel.values.add(module2)

            sectionDataModels.add(sectionDataModel)
        }

        // CAGradientLayer : CALayer
        do {
            let sectionDataModel = CQDMSectionDataModel()
            sectionDataModel.theme = "CAGradientLayer : CALayer"
            do {
                // ShimmerAnimationViewController
                let shimmerAnimationModule = CQDMModuleModel()
                shimmerAnimationModule.title = "shimmerAnimation(闪光动画)"
                shimmerAnimationModule.content = [
                    "UIView+CJShimmering",
                    "layer.mask = CAGradientLayer : CALayer",
                ].joined(separator: "\n")
                shimmerAnimationModule.classEntry = ShimmerAnimationViewController.self
                shimmerAnimationModule.isCreateByXib = true
                shimmerAnimationModule.xibBundle = Bundle(for: ShimmerAnimationViewController.self)
                sectionDataModel.values.add(shimmerAnimationModule)
            }
            sectionDataModels.add(sectionDataModel)
        }
        
        // CAShapeLayer : CALayer
        do {
            let sectionDataModel = CQDMSectionDataModel()
            sectionDataModel.theme = "CAShapeLayer : CALayer"
            do {
                // RadarAnimation
                let radarAnimationModule = CQDMModuleModel()
                radarAnimationModule.title = "RadarAnimation(雷达动画)"
                radarAnimationModule.content = [
                    "UIControl+CJRadarAnimation",
                    "layer 的 addSublayer 等于 CAShapeLayer : CALayer"
                ].joined(separator: "\n")
                radarAnimationModule.classEntry = RadarAnimationViewController.self
                sectionDataModel.values.add(radarAnimationModule)
            }
            do {
                // PeiwoAnimation
                let peiwoAnimationModule = CQDMModuleModel()
                peiwoAnimationModule.title = "PeiwoAnimation(陪我动画)"
                peiwoAnimationModule.content = [
                    "UIView+CJZoomFrame",
                    "layer 的 setMask/addSublayer 等于 CAShapeLayer : CALayer",
                ].joined(separator: "\n")
                peiwoAnimationModule.classEntry = PeiwoAnimationViewController.self
                peiwoAnimationModule.isCreateByXib = true
                peiwoAnimationModule.xibBundle = Bundle(for: PeiwoAnimationViewController.self)
                sectionDataModel.values.add(peiwoAnimationModule)
            }
            sectionDataModels.add(sectionDataModel)
        }

        self.sectionDataModels = sectionDataModels
    }
}

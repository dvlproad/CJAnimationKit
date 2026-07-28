  # 上传到github公有库:(当前使用)
  #验证方法1：pod lib lint CJAnimationKit.podspec --sources='https://github.com/CocoaPods/Specs.git' --allow-warnings --use-libraries --verbose
  #验证方法2：pod lib lint CJAnimationKit.podspec --sources=cocoapods --allow-warnings --use-libraries --verbose
  #提交方法(github公有库)： pod trunk push CJAnimationKit.podspec --allow-warnings --verbose
  
  # 上传到私有库 gitee上的私有项目: dvlproadSpecs
  #验证方法1：pod lib lint CJAnimationKit.podspec --sources='https://github.com/CocoaPods/Specs.git,https://gitee.com/dvlproad/dvlproadSpecs' --allow-warnings --use-libraries --verbose
  #验证方法2：pod lib lint CJAnimationKit.podspec --sources=cocoapods,gitee-dvlproad-dvlproadspecs --allow-warnings --use-libraries --verbose
  #提交方法(私有库)： pod repo push gitee-dvlproad-dvlproadspecs CJAnimationKit.podspec --sources=cocoapods,gitee-dvlproad-dvlproadspecs --allow-warnings --use-libraries --verbose
Pod::Spec.new do |s|
  s.name         = "CJAnimationKit"
  s.version      = "0.0.4"
  s.summary      = "各种动画相关的处理(视图转场、弹窗出现/消失、组件特效、SwiftUI 动画 + SF Symbol)"
  s.homepage     = "https://github.com/dvlproad/CJAnimationKit"

  s.description  = <<-DESC
                   各种动画相关的处理(视图转场、弹窗出现/消失、组件特效、SwiftUI 动画 + SF Symbol)，可按需独立引入：
                   • CJAnimationKit/TransitionAnimation - 视图转场动画：常见出现动画、自定义出现动画、转场动画。【如常见的出现动画：Fade淡入淡出、MoveIn覆盖、Push推挤、Reveal揭开；自定义的出现动画：Cube立方体、SuckEffect吮吸、OglFlip翻转、RippleEffect波纹、PageCurl翻页、PageUnCurl反翻页、CameraIrisHollowOpen开镜头、CameraIrisHollowClose关镜头；转场动画：None无、FlipFromLeft左翻转、FlipFromRight右翻转、CurlUp上翻页、CurlDown下翻页)】
                   
                   • CJAnimationKit/PopupAnimation - 视图显示动画：除为自己自身显示时候增加动画的功能外，还可以作为弹窗功能出现/消失的动画
                   • CJAnimationKit/PopupAnimation/Core - 位置计算器(位移位置计算器:CJExpandCalculator; 展开位置计算器:CJSlideCalculator;)
                   • CJAnimationKit/PopupAnimation/Base - 不关心隐藏的基础动画，常用于视图show带动画，也是关心隐藏的动画需要调用的底层方法（位移动画 UIView+CJSlideAnimation； 展开动画: UIView+CJExpandAnimation）
                   • CJAnimationKit/PopupAnimation/BaseBind - 关心隐藏但需自己先主动添加进superView的基础动画：绑定参数到view，show时记录，hide时复用（展开动画 UIView+CJExpandFrameAnimationBind； 位移动画 UIView+CJSlideTransformAnimationBind）  
                   • CJAnimationKit/PopupAnimation/BaseConvenience - 便捷方法：自动计算距离、小距离动画（UIView+CJSlideConvenience）

                   • CJAnimationKit/ComponentAnimation/Shake - 让 UIView 进行各种抖动效果：UIView+CJShake （密码错误抖一下、拖动时持续抖动）
                   • CJAnimationKit/ComponentAnimation/Shimmer - 闪烁加载动画：UIView+CJShimmering(类似Facebook Shimmer效果)
                   
                   • CJAnimationKit/ComponentAnimation/ShapeLayerCore - ShapeLayerCore
                   • CJAnimationKit/ComponentAnimation/Radar - 水波纹雷达动画：UIControl+CJRadarAnimation(按压水波纹)、CJAnimationFactory(动画工厂)
                   • CJAnimationKit/ComponentAnimation/ShapeLayer - 图形绘制：CAShapeLayerFactory(图形工厂)、CJGraduatedCycleView(渐变刻度圆盘)
                   • CJAnimationKit/ComponentAnimation/ZoomFrame - 缩放动画：UIView+CJZoomFrame(layer缩放动画)

                   每个子库可独立引入，详见各子库描述。
                   DESC

  #s.license      = {
  #  :type => 'Copyright',
  #  :text => <<-LICENSE
  #            © 2008-2016 Dvlproad. All rights reserved.
  #  LICENSE
  #}
  s.license      = "MIT"

  s.author   = { "dvlproad" => "" }

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/dvlproad/CJAnimationKit.git", :tag => "CJAnimationKit_0.0.4" }
  s.source_files  = "CJAnimationKit/**/*.{h,m}"

  s.frameworks = "UIKit", "QuartzCore"

  s.requires_arc = true


  # 视图转场动画：常见出现动画、自定义出现动画、转场动画。【如常见的出现动画：Fade淡入淡出、MoveIn覆盖、Push推挤、Reveal揭开；自定义的出现动画：Cube立方体、SuckEffect吮吸、OglFlip翻转、RippleEffect波纹、PageCurl翻页、PageUnCurl反翻页、CameraIrisHollowOpen开镜头、CameraIrisHollowClose关镜头；转场动画：None无、FlipFromLeft左翻转、FlipFromRight右翻转、CurlUp上翻页、CurlDown下翻页)】
  s.subspec 'TransitionAnimation' do |ss|
    ss.source_files = "CJAnimationKit/TransitionAnimation/**/*.{h,m}"
  end

  # 视图显示动画：除为自己自身显示时候增加动画的功能外，还可以作为弹窗功能出现/消失的动画
  s.subspec 'PopupAnimation' do |ss|
    # 位置计算器(位移位置计算器:CJExpandCalculator; 展开位置计算器:CJSlideCalculator;)
    ss.subspec 'Core' do |core|
      core.source_files = "CJAnimationKit/PopupAnimation/Core/**/*.{h,m}"
    end
    
    # 不关心隐藏的基础动画，常用于视图show带动画，也是关心隐藏的动画需要调用的底层方法（位移动画 UIView+CJSlideAnimation； 展开动画: UIView+CJExpandAnimation）
    ss.subspec 'Base' do |popup|
      popup.source_files = "CJAnimationKit/PopupAnimation/Base/**/*.{h,m}"
      popup.dependency "CJAnimationKit/PopupAnimation/Core" # UIView+CJSlideAnimation.h 需要 CJSlideCalculator.h 的 CJSlideFromDirection
    end

    # 关心隐藏但需自己先主动添加进superView的基础动画：绑定参数到view，show时记录，hide时复用（展开动画 UIView+CJExpandFrameAnimationBind； 位移动画 UIView+CJSlideTransformAnimationBind）
    ss.subspec 'BaseBind' do |bind|
      bind.source_files = "CJAnimationKit/PopupAnimation/BaseBind/**/*.{h,m}"
      bind.dependency 'CJAnimationKit/PopupAnimation/Base'
    end

    # 便捷方法：自动计算距离、小距离动画（UIView+CJSlideConvenience）
    ss.subspec 'BaseConvenience' do |convenience|
      convenience.source_files = "CJAnimationKit/PopupAnimation/BaseConvenience/**/*.{h,m}"
      convenience.dependency 'CJAnimationKit/PopupAnimation/BaseBind'
    end
  end

  # 组件特效动画集合
  s.subspec 'ComponentAnimation' do |ss|
    # 让 UIView 进行各种抖动效果：UIView+CJShake （密码错误抖一下、拖动时持续抖动）
    ss.subspec 'Shake' do |shake|
      shake.source_files = "CJAnimationKit/ComponentAnimation/Shake/**/*.{h,m}"
    end

    # 闪烁加载动画：UIView+CJShimmering(类似Facebook Shimmer效果)
    ss.subspec 'Shimmer' do |shimmer|
      shimmer.source_files = "CJAnimationKit/ComponentAnimation/Shimmer/**/*.{h,m}"
    end
    
    # ShapeLayerCore
    ss.subspec 'ShapeLayerCore' do |core|
      core.source_files = "CJAnimationKit/ComponentAnimation/ShapeLayerCore/**/*.{h,m}"
    end
    
    # 水波纹雷达动画：UIControl+CJRadarAnimation(按压水波纹)、CJAnimationFactory(动画工厂)
    ss.subspec 'Radar' do |radar|
      radar.source_files = "CJAnimationKit/ComponentAnimation/Radar/**/*.{h,m}"
      radar.dependency 'CJAnimationKit/ComponentAnimation/ShapeLayerCore'
    end

    # 图形绘制：CAShapeLayerFactory(图形工厂)、CJGraduatedCycleView(渐变刻度圆盘)
    ss.subspec 'ShapeLayer' do |sss|
      sss.source_files = "CJAnimationKit/ComponentAnimation/ShapeLayer/**/*.{h,m}"
    end
    
    # 缩放动画：UIView+CJZoomFrame(layer缩放动画)
    ss.subspec 'ZoomFrame' do |zoom|
      zoom.source_files = "CJAnimationKit/ComponentAnimation/ZoomFrame/**/*.{h,m}"
    end
  end


end

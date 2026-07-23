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
  s.version      = "0.0.3"
  s.summary      = "各种动画相关的处理(视图转场、弹窗出现/消失、组件特效、SwiftUI 动画 + SF Symbol)"
  s.homepage     = "https://github.com/dvlproad/CJAnimationKit"

  s.description  = <<-DESC
                   各种动画相关的处理(视图转场、弹窗出现/消失、组件特效、SwiftUI 动画 + SF Symbol)，可按需独立引入：
                   • CJAnimationKit/TransitionAnimation - 视图转场动画：常见出现动画(Fade淡入淡出、MoveIn覆盖、Push推挤、Reveal揭开)、自定义出现动画(Cube立方体、SuckEffect吮吸、OglFlip翻转、RippleEffect波纹、PageCurl翻页、PageUnCurl反翻页、CameraIrisHollowOpen开镜头、CameraIrisHollowClose关镜头)、转场动画(None无、FlipFromLeft左翻转、FlipFromRight右翻转、CurlUp上翻页、CurlDown下翻页)
                   
                   • CJAnimationKit/ComponentAnimation/Shake - view 抖动效果（密码错误抖一下、拖动时持续抖动）
                   • CJAnimationKit/ComponentAnimation/Radar - 水波纹雷达动画：UIControl+CJRadarAnimation(按压水波纹)、CJAnimationFactory(动画工厂)
                   • CJAnimationKit/ComponentAnimation/Shimmer - 闪烁加载动画：UIView+CJShimmering(类似Facebook Shimmer效果)
                   • CJAnimationKit/ComponentAnimation/ZoomFrame - 缩放动画：UIView+CJZoomFrame(layer缩放动画)
                   • CJAnimationKit/ComponentAnimation/ShapeLayer - 图形绘制：CAShapeLayerFactory(图形工厂)、CJGraduatedCycleView(渐变刻度圆盘)
                   • CJAnimationKit/ComponentAnimation/RepeatKeyWindow - 重复按键窗口：CJRepeatKeyWindow

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

  s.platform     = :ios, "12.0"

  s.source       = { :git => "https://github.com/dvlproad/CJAnimationKit.git", :tag => "CJAnimationKit_0.0.3" }
  s.source_files  = "CJAnimationKit/**/*.{h,m}"

  s.frameworks = "UIKit", "QuartzCore"

  s.requires_arc = true


  # 视图转场动画：常见出现动画、自定义出现动画、转场动画
  s.subspec 'TransitionAnimation' do |ss|
    ss.source_files = "CJAnimationKit/TransitionAnimation/**/*.{h,m}"
  end

  # 组件特效动画集合
  s.subspec 'ComponentAnimation' do |ss|
    # view 抖动效果（密码错误抖一下、拖动时持续抖动）
    ss.subspec 'Shake' do |sss|
      sss.source_files = "CJAnimationKit/ComponentAnimation/Shake/**/*.{h,m}"
    end

    # 水波纹雷达动画：UIControl+CJRadarAnimation(按压水波纹)、CJAnimationFactory(动画工厂)
    ss.subspec 'Radar' do |sss|
      sss.source_files = "CJAnimationKit/ComponentAnimation/Radar/**/*.{h,m}"
    end

    # 闪烁加载动画：UIView+CJShimmering(类似Facebook Shimmer效果)
    ss.subspec 'Shimmer' do |sss|
      sss.source_files = "CJAnimationKit/ComponentAnimation/Shimmer/**/*.{h,m}"
    end

    # 缩放动画：UIView+CJZoomFrame(layer缩放动画)
    ss.subspec 'ZoomFrame' do |sss|
      sss.source_files = "CJAnimationKit/ComponentAnimation/ZoomFrame/**/*.{h,m}"
    end

    # 图形绘制：CAShapeLayerFactory(图形工厂)、CJGraduatedCycleView(渐变刻度圆盘)
    ss.subspec 'ShapeLayer' do |sss|
      sss.source_files = "CJAnimationKit/ComponentAnimation/ShapeLayer/**/*.{h,m}"
    end

    # 重复按键窗口：CJRepeatKeyWindow
    ss.subspec 'RepeatKeyWindow' do |sss|
      sss.source_files = "CJAnimationKit/ComponentAnimation/RepeatKeyWindow/**/*.{h,m}"
    end
  end


end

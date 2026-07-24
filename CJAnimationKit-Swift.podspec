Pod::Spec.new do |s|
  # 上传到github公有库:
  #验证方法1：pod lib lint CJAnimationKit-Swift.podspec --sources='https://github.com/CocoaPods/Specs.git' --allow-warnings --use-libraries --verbose
  #验证方法2：pod lib lint CJAnimationKit-Swift.podspec --sources=cocoapods --allow-warnings --use-libraries --verbose
  #提交方法(github公有库)： pod trunk push CJAnimationKit-Swift.podspec --allow-warnings --verbose
  
  # 上传到私有库 gitee上的私有项目: dvlproadSpecs
  #验证方法1：pod lib lint CJAnimationKit-Swift.podspec --sources='https://github.com/CocoaPods/Specs.git,https://gitee.com/dvlproad/dvlproadSpecs' --allow-warnings --use-libraries --verbose
  #验证方法2：pod lib lint CJAnimationKit-Swift.podspec --sources=cocoapods,gitee-dvlproad-dvlproadspecs --allow-warnings --use-libraries --verbose
  #提交方法(私有库)： pod repo push gitee-dvlproad-dvlproadspecs CJAnimationKit-Swift.podspec --sources=cocoapods,gitee-dvlproad-dvlproadspecs --allow-warnings --use-libraries --verbose
  s.name         = "CJAnimationKit-Swift"
  s.version      = "0.0.1"
  s.summary      = "动画帮助类(Swift版)"
  s.homepage     = "https://github.com/dvlproad/CJAnimationKit.git"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                   各种动画相关的处理(视图转场、弹窗出现/消失、组件特效、SwiftUI 动画 + SF Symbol)，可按需独立引入：
                   • CJAnimationKit-Swift/SwiftUIAnimation - SwiftUI 动画集合
                   • CJAnimationKit-Swift/SwiftUIAnimation/EasyAnimation - 常见动画： 弹跳bounce \ 摇摆wiggle/swing \ 旋转rotate \ 呼吸breathe \ 脉冲pulse
                   • CJAnimationKit-Swift/SwiftUIAnimation/SymbolAnimation - SF Symbol 动画类型： 弹跳bounce\缩放scale\摇摆wiggle\旋转rotate\呼吸breathe\脉冲pulse

                   每个子库可独立引入，详见各子库描述。
                   DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "14.0"
  s.swift_version = '5.0'

  s.source       = { :git => "https://github.com/dvlproad/CJAnimationKit.git", :tag => "CJAnimationKit-Swift_0.1.2" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  # s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.frameworks   = 'UIKit', 'SwiftUI'
  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # SwiftUI 动画集合
  s.subspec 'SwiftUIAnimation' do |ss|
    # 常见动画： 弹跳bounce \ 摇摆wiggle/swing \ 旋转rotate \ 呼吸breathe \ 脉冲pulse
    ss.subspec 'EasyAnimation' do |sss|
      sss.source_files = "CJAnimationKit-Swift/SwiftUIAnimation/View+CJAnimation.swift"
    end

    # SF Symbol 动画类型： 弹跳bounce\缩放scale\摇摆wiggle\旋转rotate\呼吸breathe\脉冲pulse
    ss.subspec 'SymbolAnimation' do |sss|
      sss.source_files = "CJAnimationKit-Swift/SwiftUIAnimation/SymbolImage+CJAnimation.swift"
    end
  end

end

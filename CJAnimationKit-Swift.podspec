Pod::Spec.new do |s|
  # 上传到github公有库:
  #验证方法1：pod lib lint CJAnimationKit-Swift.podspec --sources='https://github.com/CocoaPods/Specs.git' --allow-warnings --use-libraries --verbose
  #验证方法2：pod lib lint CJAnimationKit-Swift.podspec --sources=master --allow-warnings --use-libraries --verbose
  #提交方法(github公有库)： pod trunk push CJAnimationKit-Swift.podspec --allow-warnings --verbose
  
  # 上传到私有库 gitee上的私有项目: dvlproadSpecs
  #验证方法1：pod lib lint CJAnimationKit-Swift.podspec --sources='https://github.com/CocoaPods/Specs.git,https://gitee.com/dvlproad/dvlproadSpecs' --allow-warnings --use-libraries --verbose
  #验证方法2：pod lib lint CJAnimationKit-Swift.podspec --sources=master,dvlproad --allow-warnings --use-libraries --verbose
  #提交方法(私有库)： pod repo push dvlproad CJAnimationKit-Swift.podspec --sources=master,dvlproad --allow-warnings --use-libraries --verbose
  s.name         = "CJAnimationKit-Swift"
  s.version      = "0.0.1"
  s.summary      = "动画帮助类(Swift版)"
  s.homepage     = "https://github.com/dvlproad/CJAnimationKit.git"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                   A longer description of CJAnimationKit-Swift in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "14.0"
  s.swift_version = '5.0'

  s.source       = { :git => "https://github.com/dvlproad/CJAnimationKit.git", :tag => "CJAnimationKit-Swift_0.1.2" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.frameworks   = 'UIKit', 'SwiftUI'
  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # SwiftUI 动画集合
  s.subspec 'SwiftUIAnimation' do |ss|
    # 常见动画：弹跳、摆动、旋转、木质鱼、呼吸、脉冲
    ss.subspec 'EasyAnimation' do |sss|
      sss.source_files = "CJAnimationKit-Swift/Extension/CJEasyAnimationExtension.swift"
    end

    # SF Symbol 动画类型：弹跳、缩放、摇摆、脉冲、呼吸
    ss.subspec 'SymbolAnimation' do |sss|
      sss.source_files = "CJAnimationKit-Swift/Extension/CJSymbolAnimationType.swift"
    end
  end

end

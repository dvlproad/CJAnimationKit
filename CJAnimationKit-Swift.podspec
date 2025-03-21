Pod::Spec.new do |s|
  #验证方法：pod lib lint CJAnimationKit-Swift.podspec --allow-warnings --use-libraries --verbose
  s.name         = "CJAnimationKit-Swift"
  s.version      = "0.0.1"
  s.summary      = "动画帮助类(Swift版)"
  s.homepage     = "https://github.com/dvlproad/CJUIKit.git"
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

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJAnimationKit-Swift_0.1.1" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  # 基础的常见动画
  s.subspec 'Extension' do |ss|
    ss.source_files = "CJAnimationKit-Swift/Extension/**/*.{swift}"

#    ss.dependency "CJDataVientianeSDK_Swift"#,   :path => '../../../../CJDataVientianeSDK'
  end

end

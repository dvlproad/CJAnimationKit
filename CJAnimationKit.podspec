Pod::Spec.new do |s|
  #验证方法：pod lib lint CJAnimationKit.podspec --allow-warnings --use-libraries --verbose
  s.name         = "CJAnimationKit"
  s.version      = "0.0.2"
  s.summary      = "自定义的动画"
  s.homepage     = "https://gitee.com/dvlproad/CJAnimationKit"

  s.description  = <<-DESC
                  *、CJGraduatedCycleView： 渐变的刻度圆盘

                   A longer description of CJAnimationKit in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC
  

  #s.license      = {
  #  :type => 'Copyright',
  #  :text => <<-LICENSE
  #            © 2008-2016 Dvlproad. All rights reserved.
  #  LICENSE
  #}
  s.license      = "MIT"

  s.author   = { "dvlproad" => "" }

  s.platform     = :ios, "8.0"
 
  s.source       = { :git => "https://gitee.com/dvlproad/CJAnimationKit.git", :tag => "CJAnimationKit_0.0.2" }
  s.source_files  = "CJAnimationKit/*.{h,m}"

  s.frameworks = "UIKit", "QuartzCore"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"


  s.subspec 'CJGraduatedCycleView' do |ss|
    ss.source_files = "CJAnimationKit/CJGraduatedCycleView/**/*.{h,m}"
  end


  # s.subspec 'UIView' do |ss|
  #   ss.source_files = "CJBaseUIKit/UIView/*.{h,m}"

  #   ss.subspec 'CJDragAction' do |sss|
  #     sss.source_files = "CJBaseUIKit/UIView/CJDragAction/**/*.{h,m}"
  # 	end

  # 	ss.subspec 'CJShakeAction' do |sss|
  #     sss.source_files = "CJBaseUIKit/UIView/CJShakeAction/**/*.{h,m}"
  # 	end

  # end


  # s.subspec 'CJAlert' do |ss|
  #   ss.source_files = "CJBaseUIKit/CJAlert/**/*.{h,m}"

  #   #多个依赖就写多行
  #   ss.dependency 'Masonry'
  #   ss.dependency 'CJBaseUIKit/UIView/CJPopupAction'
  # end



end

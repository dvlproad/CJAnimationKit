Pod::Spec.new do |s|
  s.name         = "TSDemo_Animation"
  s.version      = "0.0.1"
  s.summary      = "CJAnimationKit 演示示例"
  s.homepage     = "https://github.com/dvlproad/CJAnimationKit"

  s.license      = "MIT"
  s.author       = { "dvlproad" => "" }

  s.platform     = :ios, "14.0"
  s.source       = { :git => "https://github.com/dvlproad/CJAnimationKit.git", :tag => "TSDemo_Animation_0.0.1" }

  s.frameworks   = "UIKit"
  s.requires_arc = true

  s.source_files = "TSDemo_Animation/**/*.{h,m}"
  s.resources    = "TSDemo_Animation/**/*.{xib,xcassets,png,jpg}"

  s.dependency 'CJBaseUIKit/UINavigationBar'
  s.dependency "CQDemoKit"
  s.dependency "CQDemoResource/Images"
  s.dependency "CJAnimationKit"
  s.dependency "Shimmer"
end

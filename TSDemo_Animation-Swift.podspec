Pod::Spec.new do |s|
  s.name         = "TSDemo_Animation-Swift"
  s.version      = "0.0.1"
  s.summary      = "TSDemo_Animation Swift 版 - 补充使用 Swift 语言实现的动画演示界面"
  s.homepage     = "https://github.com/dvlproad/CJAnimationKit"

  s.license      = "MIT"
  s.author       = { "dvlproad" => "" }

  s.platform     = :ios, "14.0"
  s.source       = { :git => "https://github.com/dvlproad/CJAnimationKit.git", :tag => "TSDemo_Animation-Swift_0.0.1" }
  s.swift_version = "5.0"

  s.frameworks   = "UIKit", "SwiftUI"
  s.requires_arc = true

  s.source_files = "TSDemo_Animation-Swift/**/*.{swift}"

  s.dependency "TSDemo_Animation"
  s.dependency 'CJAnimationKit-Swift'
end

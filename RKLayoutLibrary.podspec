Pod::Spec.new do |s|
  s.name         = "KLayout"
  s.version      = "0.1.0"
  s.summary      = "This is an Swift Autolayout Tool that is easy to read and easy to coding for iOS."
  s.homepage     = "https://github.com/rick-ke/KLayout"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Rick Ke"  
  s.source       = { :git => "https://github.com/rick-ke/KLayout.git", :tag => "0.1.0" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source_files  = "Pod/Classes/**/*"
  s.frameworks   = "UIKit"
end

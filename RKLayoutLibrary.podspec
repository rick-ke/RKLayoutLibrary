Pod::Spec.new do |s|
  s.name         = "RKLayoutLibrary"
  s.version      = "0.1.0"
  s.summary      = "This is an Swift Autolayout Tool that is easy to read and easy to coding for iOS."
  s.homepage     = "https://github.com/rick-ke/RKLayoutLibrary"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Rick Ke"  
  s.source       = { :git => "https://github.com/rick-ke/RKLayoutLibrary.git", :tag => "0.1.0" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  # s.swift_version = ">= 3.2"
  s.source_files = "RKLayoutLibrary/Source/**/*"
  s.frameworks   = "UIKit"
end

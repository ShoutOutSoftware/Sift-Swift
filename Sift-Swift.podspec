Pod::Spec.new do |s|
  s.name         = "Sift-Swift"
  s.version      = "0.1.3"
  s.summary      = "A lightweight dictionary reading library"
  s.description  = <<-DESC
                    A light weight dictionary reading library to safely read values from a dictionary
                   DESC
  s.homepage     = "https://github.com/ShoutOutSoftware/Sift-Swift"
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author    = "ShoutOut Software"
  s.ios.deployment_target = "8.0"
  s.swift_version = '5.0'
  s.source       = { :git => "https://github.com/ShoutOutSoftware/Sift-Swift.git", :tag => s.version }
  s.source_files = 'Sift/*.swift'
end

Pod::Spec.new do |s|
  s.name             = 'NeonCameraIos'
  s.version          = '1.0.1'
  s.summary          = 'By far the most NeonCameraIos I have seen in my entire life. No joke.'
 
  s.description      = <<-DESC
This NeonCameraIos changes its color gradually makes your app look fantastic!
                       DESC
 
  s.homepage         = 'https://github.com/nehamishragaadi/NeonCameraPOd'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Neha Mishra' => 'neha.mishra@gaadi.com' }
  s.source = { :git => 'https://github.com/nehamishragaadi/NeonCameraPOd.git', :tag => s.version }

s.ios.deployment_target = '10.0'

s.source_files = "Neon-Ios/**.{swift,h,m}"
s.resources = "Neon-Ios/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
s.swift_version = "5.0"
 
end
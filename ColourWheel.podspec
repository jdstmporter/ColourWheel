#
# Be sure to run `pod lib lint ColourWheel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ColourWheel'
  s.version          = '0.5.1'
  s.summary          = 'A simple swift colour wheel based colour picker widget.'
  s.swift_version    = '5'

  s.description      = <<-DESC
A swift colour picker widget for swift 5 in iOS 12.0 and later.  It is an extended fork
of the Objective-C library at https://github.com/justinmeiners/ios-color-wheel.
                       DESC

  s.homepage         = 'https://github.com/jdstmporter/ColourWheel.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jdstmporter' => 'julian@porternet.org.uk' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform = :ios
  s.ios.deployment_target = '12.0'

  s.source = { :git => 'https://github.com/jdstmporter/ColourWheel.git', :tag => "#{s.version}" }
  s.source_files = 'ColourWheelFramework/src/*.{swift}'
  s.frameworks   = 'UIKit'
  
  # s.resource_bundles = {
  #   'ColourWheel' => ['ColourWheel/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
end



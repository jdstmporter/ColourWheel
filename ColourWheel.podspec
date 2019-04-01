#
# Be sure to run `pod lib lint ColourWheel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ColourWheel'
  s.version          = '0.4.1'
  s.summary          = 'A simple swift colour wheel based colour picker widget.'
  s.swift_version    = '4.2'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A swift colour picker widget for swift 4 in iOS 11.0 and later.  It is an extended fork
of the Objective-C library at https://github.com/justinmeiners/ios-color-wheel.
                       DESC

  s.homepage         = 'https://github.com/jdstmporter/ColourWheel.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jdstmporter' => 'julian@porternet.org.uk' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform = :ios
  s.ios.deployment_target = '11.0'

  s.source = { :git => 'https://github.com/jdstmporter/ColourWheel.git', :tag => "#{s.version}" }
  s.source_files = 'ColourWheelFramework/src/*.{swift}'
  s.frameworks   = 'UIKit'
  
  # s.resource_bundles = {
  #   'ColourWheel' => ['ColourWheel/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end



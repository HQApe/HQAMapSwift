#
# Be sure to run `pod lib lint HQAMapSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HQAMapSwift'
  s.version          = '0.1.0'
  s.summary          = 'HQAMapSwift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
HQAMapSwift,Swift 版本高德地图集成
                       DESC

  s.homepage         = 'https://github.com/HQApe/HQAMapSwift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HQApe' => 'ape.zhang@corp.to8to.com' }
  s.source           = { :git => 'https://github.com/HQApe/HQAMapSwift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  
  s.source_files = 'HQAMapSwift/Classes/**/*.{swift,h,m}'
  
  # s.resource_bundles = {
  #   'HQAMapSwift' => ['HQAMapSwift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.frameworks = 'JavaScriptcore','SystemConfiguration','CoreTelephony','CoreLocation','Security','GLKit','OpenGLES','UIKit','Foundation','CoreGraphics','QuartzCore','CoreLocation','AdSupport','ExternalAccessory','AMapFoundationKit','AMapLocationKit','AMapSearchKit','MAMapKit'
  s.libraries = 'z','c++','stdc++'
  
  s.dependency 'AMap3DMap'
  s.dependency 'AMapSearch'
  s.dependency 'AMapLocation'
  
end

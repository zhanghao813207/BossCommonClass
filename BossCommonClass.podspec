#
# Be sure to run `pod lib lint BossCommonClass.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BossCommonClass'
  s.version          = '0.1.1'
  s.summary          = 'a common class of boss system'
#s.static_framework = true

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
these are common classes,they are used by boss system.
                       DESC

  s.homepage         = 'https://git.coding.net/J_YC/BossCommonClass.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JiaYuanchao' => 'yuanchao__2106@163.com' }
  s.source           = { :git => 'https://git.coding.net/J_YC/BossCommonClass.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'BossCommonClass/Classes/**/*'
  # s.resource_bundles = {
  #   'BossCommonClass' => ['BossCommonClass/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'BasicCommonClass', '~> 0.1.0'
  s.dependency 'AFNetworking', '~> 3.1.0'
  s.dependency 'Qiniu', '~> 7.1'
  s.dependency 'BGFMDB', '~> 1.51'

end

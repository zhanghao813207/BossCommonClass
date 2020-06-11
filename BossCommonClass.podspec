#
# Be sure to run `pod lib lint BossCommonClass.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BossCommonClass'
  s.version          = '9.0.2'
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

  s.homepage         = 'git@github.com:zhanghao813207/BossCommonClass.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhanghao' => 'zh508149687@gmail.com' }
  s.source           = { :git => 'git@github.com:zhanghao813207/BossCommonClass.git', :tag => s.version.to_s }
  # s.source           = { :git => '~/soft/develop/ios/BossCommonClass-master'}
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.ios.frameworks = 'AVFoundation','Foundation'
  s.source_files = 'BossCommonClass/Classes/**/*'
  s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
   s.resource_bundles = {
     'BossCommonClass' => ['BossCommonClass/Assets/*'],
   }
  # s.vendored_frameworks = ['AVFoundation.framework']
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 3.0'
  
  # 七牛
  s.dependency 'Qiniu', '~> 7.1'
  s.dependency 'HappyDNS'
  
  s.dependency 'BGFMDB', '~> 1.51'
  s.dependency 'Masonry'
  s.dependency 'SGPagingView', '~> 1.6.0'
  s.dependency 'MJExtension'
  s.dependency 'MJRefresh'
  s.dependency 'SDWebImage', '~> 5.0.1'
  s.dependency 'MQTTClient', '~> 0.15.2'
  s.dependency 'mob_linksdk_pro', '3.3.1'
  s.dependency 'LinkedME_LinkPage'
  # 友盟基础库
  s.dependency 'UMCCommon'
  # 'UMCSecurityPlugins'为安全组件，不需要开发者显式调用，为开发者提供安全的数据环境，能有效的防止刷量和反作弊等行为，属于可选项，如果对App的数据安全性要求不高的话，可以去掉
  #注释UMCSecurityPlugins ,因为它与支付宝支付UTDID.framework有冲突
#  s.dependency 'UMCSecurityPlugins'
  # 友盟Push库
  s.dependency 'UMCPush'
  # 友盟日志库（调试）
  s.dependency 'UMCCommonLog'
  # 友盟统计
  s.dependency 'UMCAnalytics'
  
  s.dependency 'MGJRouter', '~> 0.10.0'
  s.dependency 'Realm', '~> 3.17.0'
  s.dependency 'IQKeyboardManager'
  
#  s.dependency 'WSDatePickerView'
end

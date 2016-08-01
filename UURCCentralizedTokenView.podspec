#
# Be sure to run `pod lib lint UURCCentralizedTokenView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UURCCentralizedTokenView'
  s.version          = '0.1.1'
  s.summary          = 'Customizable Centralized TokenView'
  s.description      = 'Customizable Centralized TokenView for iOS applications.'

  s.homepage         = 'https://github.com/ugurcetinkaya/UURCCentralizedTokenView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ugur Cetinkaya' => 'ugurcetinkaya@ymail.com' }
  s.source           = { :git => 'https://github.com/ugurcetinkaya/UURCCentralizedTokenView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ceuur'

  s.ios.deployment_target = '8.0'

  s.source_files = 'UURCCentralizedTokenView/Classes/*'

  s.frameworks = 'UIKit'
end

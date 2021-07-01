#
# Be sure to run `pod lib lint TrophyKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TrophyKit'
  s.version          = '0.2'
  s.summary          = 'An animated trophy banner that looks like Xbox achievement.'
  s.description      = <<-DESC
  An animated trophy banner that looks like Xbox achievement.
                       DESC

  s.homepage         = 'https://github.com/xnth97/TrophyKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yubo Qin' => 'xnth97@live.com' }
  s.source           = { :git => 'https://github.com/xnth97/TrophyKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.0'

  s.source_files = 'TrophyKit/Classes/**/*'

  s.frameworks = 'UIKit'

end

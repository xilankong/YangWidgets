Pod::Spec.new do |s|
  s.name             = 'YangWidgets'
  s.version          = '0.1.0'
  s.summary          = 'widgets in development'

# 开发中常用的小工具合集

  s.description      = <<-DESC
TODO: widgets in development
                       DESC

  s.homepage         = 'https://github.com/xilankong/YangWidgets'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xilankong' => '851384557@qq.com' }
  s.source           = { :git => 'https://github.com/xilankong/YangWidgets.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'YangWidgets/Classes/**/*'
  s.resource = 'YangWidgets/Assets/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

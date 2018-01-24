Pod::Spec.new do |s|
  s.name             = 'YangWidgets'
  s.version          = '1.0.4'
  s.summary          = 'widgets in development'

# 开发中常用的小工具合集

  s.description      = <<-DESC
TODO: widgets in development
                       DESC
  s.ios.deployment_target = '8.0'
  s.homepage         = 'https://github.com/xilankong/YangWidgets'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xilankong' => '851384557@qq.com' }
  s.source           = { :git => 'https://github.com/xilankong/YangWidgets.git', :tag => s.version.to_s }

    s.subspec 'YangPageControl' do |page|
        page.source_files = 'YangWidgets/Classes/YangPageControl/**/*'
    end

    s.subspec 'YangDropMenuView' do |menu|
        menu.source_files = 'YangWidgets/Classes/YangDropMenuView/**/*'
    end

    s.subspec 'YangDragButton' do |drag|
        drag.source_files = 'YangWidgets/Classes/YangDragButton/**/*'
    end

    s.subspec 'YangHub' do |hub|
        hub.source_files = 'YangWidgets/Classes/YangHub/**/*'
        hub.resource = 'YangWidgets/Assets/YangHub/**/*'
    end

    s.subspec 'YangSliderView' do |slide|
        slide.source_files = 'YangWidgets/Classes/YangSliderView/**/*'
    end

    s.subspec 'YangTabBarController' do |tabbar|
        tabbar.source_files = 'YangWidgets/Classes/YangTabBarController/**/*'
    end
end

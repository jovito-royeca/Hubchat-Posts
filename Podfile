platform :ios, '9.0'

use_frameworks!

target 'Hubchat Posts' do
    pod 'Alamofire', '~> 4.3'
    pod 'MBProgressHUD'
    pod 'SnapKit', '~> 3.1.2'
    pod 'Sync'
end

target 'Hubchat PostsTests' do
    pod 'Alamofire', '~> 4.3'
    pod 'MBProgressHUD'
    pod 'SnapKit', '~> 3.1.2'
    pod 'Sync'
end

target 'Hubchat PostsUITests' do
    pod 'Alamofire', '~> 4.3'
    pod 'MBProgressHUD'
    pod 'SnapKit', '~> 3.1.2'
    pod 'Sync'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

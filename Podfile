# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'Ruangguru' do
# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

# Pods for Ruangguru
pod 'RealmSwift'
pod 'Alamofire'
pod 'SwiftyJSON'
pod 'Swinject'
pod 'NotificationBannerSwift'
pod 'NVActivityIndicatorView'

end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF'] = false
		end
	end
end

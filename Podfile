# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'Seena Patient' do
# Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
# ignore all warnings from all pods
  inhibit_all_warnings!
# Pods for Seena Patient

  pod 'IBAnimatable'
  pod 'Moya'
  pod 'IQKeyboardManagerSwift'
  pod 'Kingfisher', '~> 5.0'
  pod 'UIScrollView-InfiniteScroll', '~> 1.0.0'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod "SkeletonView"
  pod 'MOLH'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['Moya','IBAnimatable','IQKeyboardManagerSwift','Kingfisher'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '5.0'
      end
    end
  end
end

use_modular_headers!

platform :ios, '12.0'

target 'TestDiagonalDisplayMode' do
  inhibit_all_warnings!

  pod 'VATextureKitRx'
  pod 'Swiftional'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end

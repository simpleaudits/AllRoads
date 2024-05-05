# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'RSAC' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  pod 'Firebase/Auth'
  pod 'FirebaseUI'
  pod 'Firebase/Core'
  pod 'SwiftLoader' , "1.0.0"
  pod 'TPPDF' , "2.4.1"
  pod 'QRCodeReader.swift', "10.1.0"

  
  



#  post_install do |installer|
#    installer.pods_project.targets.each do |target|
#      target.build_configurations.each do |config|
#        xcconfig_path = config.base_configuration_reference.real_path
#        xcconfig = File.read(xcconfig_path)
#        xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
#        File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
#      
#        
#      end
#    end
#  end
  

  post_install do |pi|
      pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
          
          xcconfig_path = config.base_configuration_reference.real_path
          xcconfig = File.read(xcconfig_path)
          xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
          File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
          
          
        end
      end
    end
  

  
  

  target 'RSACTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RSACUITests' do
    # Pods for testing
  end

end


  
  

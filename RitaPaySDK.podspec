Pod::Spec.new do |spec|

  spec.name         = "RitaPaySDK"
  spec.version      = "0.0.2"
  spec.summary      = "RitaPaySDK is pure-swift API to process your payment in iOS applications through Rittal payment gateway."

  spec.homepage     = "https://github.com/Rittalsd/SDK_IOS_PLUGIN.git"

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Jihad Mahmoud" => "jihad.fayz@gmail.com" }

  spec.platform     = :ios
  spec.ios.deployment_target = "10.0"
  spec.swift_version = "5.0"

  spec.source       = { :git => "https://github.com/Rittalsd/RitaPaySDK.git", :tag => "#{spec.version}" }

  spec.source_files  = "RitaPaySDK/**/*.{swift}"
  spec.resources = "RitaPaySDK/**/*.{xcassets,jpg,jpeg,png,strings}"

end

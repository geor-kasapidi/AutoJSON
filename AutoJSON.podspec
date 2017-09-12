Pod::Spec.new do |s|
  s.name                  = "AutoJSON"
  s.version               = "0.0.1"
  s.summary               = "Comfort way to manage json in your app"
  s.homepage              = "https://github.com/geor-kasapidi/AutoJSON"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.authors               = { "Geor Kasapidi" => "geor.kasapidi@icloud.com" }
  s.platform              = :ios, "7.0"
  s.source                = { :git => "https://github.com/geor-kasapidi/AutoJSON.git", :tag => "v#{s.version}" }
  s.source_files          = "AutoJSON/*.{h,m}"
  s.public_header_files   = "AutoJSON/*.h"
  s.frameworks            = "Foundation"
  s.requires_arc          = true
end

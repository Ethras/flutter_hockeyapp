#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_hockeyapp'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin integrating HockeyApp SDK'
  s.description      = <<-DESC
A Flutter plugin integrating HockeyApp SDK
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'HockeySDK-Source', '5.1.2'
  
  s.ios.deployment_target = '8.0'
end


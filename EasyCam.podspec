Pod::Spec.new do |s|
  s.name             = 'EasyCam'
  s.version          = '1.0'
s.summary          = "The easiest way to take or select a picture in iOS, because it shouldn't take an hour"

  s.description      = <<-DESC
The easiest way to take or select a picture in iOS, because it shouldn't take an hour
                       DESC

  s.homepage         = 'https://github.com/shalomfriss/EasyCam'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shalomfriss' => 'shalomfriss@gmail.com' }
  s.source           = { :git => 'https://github.com/shalomfriss/EasyCam.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'EasyCam/Classes/**/*'
  

end

Pod::Spec.new do |s|
  s.name             = 'VHWaveView'
  s.version          = '0.0.3'
  s.summary          = 'Attributes gradually-changed WaveView ～～～～～'
  s.description      = <<-DESC
                       VHWaveView is an attributes gradually-changed wave-view ～～～～～
                         DESC
  s.homepage         = 'https://github.com/Nightonke/VHWaveView'
  s.license          = 'MIT'
  s.author           = { 'Nightonke' => "2584541288@qq.com" } 
  s.source           = { :git => 'https://github.com/Nightonke/VHWaveView.git', :tag => '0.0.3' }
  s.platform         = :ios, '7.0'
  s.requires_arc     = true
  
  s.source_files     = 'VHWaveView/**/*.{h,m}' 
  s.frameworks        = 'UIKit'
end
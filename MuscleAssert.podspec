
Pod::Spec.new do |s|
  s.name         = "MuscleAssert"
  s.version      = "1.0.0"
  s.summary      = "A unit test framework for Objective-C using computation expressions."
  s.homepage     = "https://github.com/akuraru/MuscleAssert-Objective-C"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "akuraru" => "akuraru@gmail.com" }
  s.source       = {
    :git => "https://github.com/akuraru/MuscleAssert-Objective-C.git",
    :tag => s.version.to_s
  }
  s.platform     = :ios, '9.0'

  s.default_subspec = 'ObjC'

  s.subspec 'All' do |ss|
    ss.dependency 'MuscleAssert/ObjC'
  end
  s.subspec 'ObjC' do |ss|
    ss.source_files = 'MuscleAssert/ObjC/**/*.{h,m}'
  end
end

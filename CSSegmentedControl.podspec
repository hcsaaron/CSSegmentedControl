Pod::Spec.new do |s|
  s.name         = "CSSegmentedControl"
  s.version      = "1.0"
  s.platform     = :ios, "10.0"
  s.license      = "MIT"
  s.summary      = "The popular segmentedControl in currency"
  s.homepage     = "https://github.com/hcsaaron/CSSegmentedControl"
  s.author       = { "Aaron" => "hcsaaron@163.com" }
  s.source       = { :git => "https://github.com/hcsaaron/CSSegmentedControl.git", :tag => s.version.to_s }
  s.description  = "CSSegmentedControl is a clean and easy-to-use custom SegmentedControl meant to show any item"
  s.source_files = "CSSegmentedControl/**/*.{h,swift}"
  s.resource     = 'CSSegmentedControl/Resource/CSSegmentedControl.bundle'
  s.requires_arc = true
end

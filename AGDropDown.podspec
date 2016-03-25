Pod::Spec.new do |s|
	s.name			= "AGDropDown"
	s.version		= "1.0.0"
	s.summary		= "A dropdownlist view used on iOS."
	s.description	= <<-DESC
						It is a dropdownlist view used on iOS, which implement by Swift.
						DESC
	s.homepage		= "https://github.com/xjmeplws/AGDropdown"
	s.license		= "MIT"
	s.author		= {"xjmeplws" => "576494724@qq.com"}
	s.source		= {:git => "https://github.com/xjmeplws/AGDropdown.git", :tag => s.version.to_s}
	s.platform		= :ios, '8.0'
	s.requires_arc	= true
	s.source_files	= 'AGDropDown/*'
	s.frameworks	= 'Foundation', 'UIKit'

end